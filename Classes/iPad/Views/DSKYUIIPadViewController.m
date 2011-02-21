    //
//  DSKYUIIPadViewController.m
//  iAGC
//
//  Created by argaldo on 2/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DSKYUIIPadViewController.h"
#import "Util.h"


@implementation DSKYUIIPadViewController

@synthesize segments;
@synthesize dskySimulationClient;
@synthesize M1Outlet,M2Outlet,V1Outlet,V2Outlet,N1Outlet,N2Outlet,CompActIndOutlet,uplinkActivity,noAttitude,standBy,keyRelease,operationError,priorityDisplay,noDAP,temp,gimbalLock,prog,restart,tracker,alt,vel,_r1plusminus,_11Outlet,	_12Outlet,_13Outlet,_14Outlet,_15Outlet,_r2plusminus,_21Outlet,_22Outlet,_23Outlet,_24Outlet,_25Outlet,_r3plusminus,_31Outlet,_32Outlet,_33Outlet,_34Outlet,_35Outlet;

- (void) initSegmentDictionary {	
	//TODO change this to use a NSDictionary ... 
	// initializing segment dictionary
	segments = [[NSMutableDictionary alloc] init];
	[segments setObject:self.M1Outlet forKey:@"M1"];
	[segments setObject:self.M2Outlet forKey:@"M2"];
	[segments setObject:self.V1Outlet forKey:@"V1"];
	[segments setObject:self.V2Outlet forKey:@"V2"];
	[segments setObject:self.N1Outlet forKey:@"N1"];
	[segments setObject:self.N2Outlet forKey:@"N2"];
	[segments setObject:self._11Outlet forKey:@"11"];
	[segments setObject:self._12Outlet forKey:@"12"];
	[segments setObject:self._13Outlet forKey:@"13"];
	[segments setObject:self._14Outlet forKey:@"14"];
	[segments setObject:self._15Outlet forKey:@"15"];
	[segments setObject:self._21Outlet forKey:@"21"];
	[segments setObject:self._22Outlet forKey:@"22"];
	[segments setObject:self._23Outlet forKey:@"23"];
	[segments setObject:self._24Outlet forKey:@"24"];
	[segments setObject:self._25Outlet forKey:@"25"];
	[segments setObject:self._31Outlet forKey:@"31"];
	[segments setObject:self._32Outlet forKey:@"32"];
	[segments setObject:self._33Outlet forKey:@"33"];
	[segments setObject:self._34Outlet forKey:@"34"];
	[segments setObject:self._35Outlet forKey:@"35"];
	[segments setObject:self._r1plusminus forKey:@"R1"];
	[segments setObject:self._r2plusminus forKey:@"R2"];
	[segments setObject:self._r3plusminus forKey:@"R3"];
	[segments setObject:self.CompActIndOutlet forKey:@"CompActInd"];
	[segments setObject:self.operationError forKey:@"opError"];
	[segments setObject:self.keyRelease forKey:@"keyRel"];
	[segments setObject:self.uplinkActivity forKey:@"uplinkActivity"];
	[segments setObject:self.temp forKey:@"tempCaution"];
	[segments setObject:self.vel forKey:@"VelInd"];
	[segments setObject:self.noAttitude forKey:@"NoAttInd"];
	[segments setObject:self.alt forKey:@"AltInd"];
	[segments setObject:self.gimbalLock forKey:@"GimbalLockInd"];
	[segments setObject:self.tracker forKey:@"TrackerInd"];
	[segments setObject:self.prog forKey:@"ProgInd"];
}

- (void) sendDSKYCode:(int) code {
	// wrapper over DSKYSimulationClient instance to send dsky data
	NSLog(@"enviado");
	[dskySimulationClient sendDSKYCode:code];
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	[self initSegmentDictionary];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

// key handling code
- (IBAction) pressedVerb: (id) sender{
	[self sendDSKYCode:17];
}

- (IBAction) pressedNoun: (id) sender{
	[self sendDSKYCode:31];
}

- (IBAction) pressed1: (id) sender{
	[self sendDSKYCode:1];
}
- (IBAction) pressed2: (id) sender{
	[self sendDSKYCode:2];
}

- (IBAction) pressed3: (id) sender{
	[self sendDSKYCode:3];
}
- (IBAction) pressed4: (id) sender{
	[self sendDSKYCode:4];
}
- (IBAction) pressed5: (id) sender{
	[self sendDSKYCode:5];
}
- (IBAction) pressed6: (id) sender{
	[self sendDSKYCode:6];
}
- (IBAction) pressed7: (id) sender{
	[self sendDSKYCode:7];
}
- (IBAction) pressed8: (id) sender{
	[self sendDSKYCode:8];
}
- (IBAction) pressed9: (id) sender{
	[self sendDSKYCode:9];
}
- (IBAction) pressed0: (id) sender{
	[self sendDSKYCode:16];
}
- (IBAction) pressedEnter: (id) sender{
	[self sendDSKYCode:28];
}

- (IBAction) pressedClr: (id) sender {
	[self sendDSKYCode:30];
}
- (IBAction) pressedPro: (id) sender {
	//falta este
	[self sendDSKYCode:28];
}
- (IBAction) pressedKeyRel: (id) sender{
	[self sendDSKYCode:25];
}
- (IBAction) pressedPlus: (id) sender{
	[self sendDSKYCode:26];
}

- (void) changeSegmentValue: (NSMutableArray *) args {
	NSLog(@"ChangeSegmentValue");
	NSString *component = [args objectAtIndex:0];
	NSString *imageName = (NSString *)[args objectAtIndex:1];

	if ([imageName compare:@""] != NSOrderedSame) {
		UIImageView *segmentImage = [self.segments objectForKey:component];
		[segmentImage setImage:[UIImage imageNamed:imageName]];
		segmentImage.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:imageName],[UIImage imageNamed:@"digit-off.jpg"],nil];
	}
}

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType {
	[self updateUserInterface:component withValue:value withComponentType:componentType withComponentSubtype:0];
}
- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType withComponentSubtype:(int) componentSubtype {
	switch (componentType){
		case SEGMENT:
			[self performSelectorOnMainThread:@selector(changeSegmentValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForSegmentValue:value],nil] waitUntilDone:YES];
			break;
		case SIGN:
			[self performSelectorOnMainThread:@selector(changeSignValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForSignValue:value],nil] waitUntilDone:YES];
			break;
		/*case INDICATOR:
			[self performSelectorOnMainThread:@selector(changeIndicatorValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForIndicatorType:componentSubtype withValue:value],[NSNumber numberWithInt:componentSubtype], nil] waitUntilDone:YES];
			break;*/
		default:
			break;
	}
}
- (void) toggleVerbNounFlashStatus:(BOOL)flash{
	NSLog(@"toggleVerbNounFlashStatus");
}



@end
