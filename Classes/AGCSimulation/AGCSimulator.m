//
//  AGCSimulator.m
//  iAGC
//
//  Created by argaldo on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AGCSimulator.h"
#include "agc_simulator.h"
#include "agc_cli.h"


@implementation AGCSimulator

@synthesize simulatorThread,coreRopeROM;

static Options_t Options;  // AGC simulator options
static Simulator_t Simulator; // Simulator data structure
static int simulating = 0;


- (id) initWithROM:(NSString *)rom{
	self = [super init];
	self.coreRopeROM = rom;
	return self;
}

- (BOOL) isSimulationRunning {
	return (simulating)?YES:NO;
}


static void _CliInitializeOptions(void) {
	// Default AGC simulator options
	Options.core = (char*)0;
	Options.resume = (char*)0;
	Options.cdu_log = (char*)0;
	Options.symtab = (char*)0;
	Options.directory = (char*)0;
	Options.cd = (char*)0;
	Options.cfg = (char*)0;
	Options.fromfile = (char*)0;
	Options.port  = 19697;
	Options.dump_time = 10;
	Options.debug_dsky = 0;
	Options.debug_deda = 0;
	Options.deda_quiet = 0;
	Options.quiet = 0;
	Options.fullname = 0;
	Options.debug = 1;
	Options.resumed = 0;
	Options.interlace = 50;
	Options.version = 0;
}

static void _SimSleep(void) {
	// sleeping
	struct timespec req, rem;
	req.tv_sec = 0;
	req.tv_nsec = 10000000;
	nanosleep (&req, &rem);
}

static void _SimExecuteEngine() {
	
	// Just a wrapper over agc_engine 
	
	agc_engine (&Simulator.State);
}

static void _SimSetCycleCount(int Mode) {
	
	// Tick count 
	
	switch(Mode)
	{
		case SIM_CYCLECOUNT_AGC:
			Simulator.CycleCount = sysconf (_SC_CLK_TCK) * Simulator.State.CycleCounter;
			break;
		case SIM_CYCLECOUNT_INC:
			Simulator.CycleCount += sysconf (_SC_CLK_TCK);
			break;
	}
}

int _SimInitialize(Options_t* Options) {
	int result = 0;
	// No options, no simulation, sorry :(
	if (!Options) return(6);
	
	// default simulation parameters
	Simulator.Options = Options;
	Simulator.DebugRules = DebugRules;
	Simulator.DumpInterval = Options->dump_time * sysconf (_SC_CLK_TCK);
	
	Simulator.RealTimeOffset = times (&Simulator.DummyTime);        // The starting time of the program.
	Simulator.NextCoreDump = Simulator.RealTimeOffset + Simulator.DumpInterval;
	_SimSetCycleCount(SIM_CYCLECOUNT_AGC); // Num. of AGC cycles so far.
	Simulator.RealTimeOffset -= (Simulator.CycleCount + AGC_PER_SECOND / 2) / AGC_PER_SECOND;
	Simulator.LastRealTime = ~0UL;
	return (result | Options->version);
}

static void _SimManageTime(void) {
	// Simulated time synchronization routine
	Simulator.RealTime = times (&Simulator.DummyTime);
	if (Simulator.RealTime != Simulator.LastRealTime)
	{
		Simulator.LastRealTime = Simulator.RealTime;
		Simulator.DesiredCycles = Simulator.RealTime;
		Simulator.DesiredCycles -= Simulator.RealTimeOffset;
		Simulator.DesiredCycles *= AGC_PER_SECOND;
	}
	else {
		_SimSleep();
	}
		
}


- (void) agcSimulator {
	
	// This is the simulation itself
	
	int started;
	
	// initialization 
	_CliInitializeOptions();
	_SimInitialize(&Options);
	
	// Core-rope rom reference
	NSString *romPath = [[NSBundle mainBundle] pathForResource:self.coreRopeROM ofType:@"bin"];
	
	started = agc_engine_init(&Simulator.State,[romPath fileSystemRepresentation],NULL,1);
	if (started) {
		printf("[iAGC] No se ha conseguido iniciar agc_engine %i\n",started);
	}
	printf("[iAGC] iniciado: %i\n",started);
	// infite loop
	while(1){
		// manage simulated time
		_SimManageTime();
		while (Simulator.CycleCount < Simulator.DesiredCycles)
		{
			// Execute a cyle of the AGC  engine 	
			_SimExecuteEngine();
			//Adjust the CycleCount 
			_SimSetCycleCount(SIM_CYCLECOUNT_INC);
		}
	}
	
}

- (void) launchSimulatorThreadDelegate {
	// Launching simulator thread
	
	self.simulatorThread = [[NSThread alloc] initWithTarget:self selector:@selector(agcSimulator) object:nil];
	[self.simulatorThread start];
}


- (void) launchSimulatorThread {
	
	// invoking delegate to launch simulator thread on main thread in order to not block the user interface

	[self performSelectorOnMainThread:@selector(launchSimulatorThreadDelegate) withObject:nil waitUntilDone:NO];
}

- (void) stopSimulationThread {
	[self.simulatorThread cancel];
}


@end
