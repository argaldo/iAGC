//
//  AppDelegate_iPhone.m
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "DSKYSimulationClient.h"
#import "AGCSimulator.h"
#import "DSKYUplinkData.h"
#import "UplinkDataViewController.h"

@implementation AppDelegate_iPhone

@synthesize tabBarController,dskyUIIPhoneViewController,simulator,dskyClient;



#pragma mark -
#pragma mark Application lifecycle

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType {
	NSLog(@"update");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	// wiring dataviewcontroller
	NSMutableArray *tabBarViewControllers = [NSMutableArray arrayWithArray:[self.tabBarController viewControllers]];
	[tabBarViewControllers removeLastObject];
	UplinkDataViewController *uplinkDataViewController = [[UplinkDataViewController alloc] initInManagedObjectContext:self.managedObjectContext];
	[tabBarViewControllers addObject:uplinkDataViewController];
	[self.tabBarController setViewControllers:tabBarViewControllers];
	
	
	// Setting default data uplink entries
	
	[DSKYUplinkData createDSKYUplinkDataWithTitle:@"Monitor mission time" withData:@"V16N36E" inManagedObjectContext:self.managedObjectContext];
	
	
	// Launching simulator
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	
	if ( [preferences boolForKey:@"sim_start_preference"] ) {
		NSLog(@"Lanzando simulator thread");
		self.simulator = [[AGCSimulator alloc] initWithROM:[preferences stringForKey:@"core_rope"]];
		[self.simulator launchSimulatorThread];
	}
	
	
	if ( [preferences boolForKey:@"autoconnect_preference"] ) {
		NSLog(@"Lanzando DSKY thread");
		//DSKYSimulationClient *dskyClient = [[DSKYSimulationClient alloc] initWithHost:@"localhost" withPort:19700];
		self.dskyClient = [[DSKYSimulationClient alloc] initWithDelegate:dskyUIIPhoneViewController];
		[self.dskyClient launchDSKYIOListeningThread];
	}
	
	
	dskyUIIPhoneViewController.dskySimulationClient = self.dskyClient;
	
    // Override point for customization after application launch.
	[window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)dealloc {    
	[tabBarController release];
	[dskyUIIPhoneViewController release];
	[simulator release];
	[dskyClient release];
    [window release];
    [super dealloc];
}

@end
