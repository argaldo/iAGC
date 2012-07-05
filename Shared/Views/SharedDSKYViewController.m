    //
//  SharedDSKYViewController.m
//  iAGC
//
//  Created by argaldo on 2/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SharedDSKYViewController.h"
#import "DSKYUIIPadViewController.h"
#import "Util.h"

@implementation SharedDSKYViewController

@synthesize segments;
@synthesize dskySimulationClient;
@synthesize M1Outlet,M2Outlet,V1Outlet,V2Outlet,N1Outlet,N2Outlet,CompActIndOutlet,uplinkActivity,noAttitude,standBy,keyRelease,operationError,priorityDisplay,noDAP,temp,gimbalLock,prog,restart,tracker,alt,vel,_r1plusminus,_11Outlet,	_12Outlet,_13Outlet,_14Outlet,_15Outlet,_r2plusminus,_21Outlet,_22Outlet,_23Outlet,_24Outlet,_25Outlet,_r3plusminus,_31Outlet,_32Outlet,_33Outlet,_34Outlet,_35Outlet;
@synthesize verbNounFlashTimer;
BOOL verbNounVisible = YES;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


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
	[dskySimulationClient sendDSKYCode:code];
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

- (IBAction) pressedReset: (id) sender {
	[self sendDSKYCode:18];
}

- (IBAction) pressedMinus: (id) sender {
	[self sendDSKYCode:27];
}

- (void) changeSegmentValue: (NSMutableArray *) args {
	NSString *component = [args objectAtIndex:0];
	NSString *imageName = (NSString *)[args objectAtIndex:1];
	
	if ([imageName compare:@""] != NSOrderedSame) {
		UIImageView *segmentImage = [self.segments objectForKey:component];
		[segmentImage setImage:[UIImage imageNamed:imageName]];
		segmentImage.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:imageName],[UIImage imageNamed:@"digit-off.jpg"],nil];
	}
}

- (void) changeSignValue: (NSMutableArray *) args {
	NSString *component = [args objectAtIndex:0];
	NSString *imageName = (NSString *)[args objectAtIndex:1];
	if ([imageName compare:@""] != NSOrderedSame) {
		UIImageView *segmentImage = [segments objectForKey:component];
		[segmentImage setImage:[UIImage imageNamed:imageName]];
	}
}

- (void) changeIndicatorValue: (NSMutableArray *) args {
	NSString *component = [args objectAtIndex:0];
	NSString *imageName = (NSString *)[args objectAtIndex:1];
	int indicator = [(NSNumber *)[args objectAtIndex:2] intValue];
	if ([imageName compare:@""] != NSOrderedSame) {
		UIImageView *segmentImage = [segments objectForKey:component];
		[segmentImage setImage:[UIImage imageNamed:imageName]];
		if (indicator == 1){
			// OppErr
			segmentImage.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:imageName],[UIImage imageNamed:@"OprErrOff.jpg"],nil];
			segmentImage.animationDuration = 0.666;
			[segmentImage startAnimating];
		} else if( indicator == 2) {
			// Key rel
			segmentImage.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:imageName],[UIImage imageNamed:@"KeyRelOff.jpg"],nil];
			segmentImage.animationDuration = 0.666;
			[segmentImage startAnimating];
		}
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
		case INDICATOR:
			 [self performSelectorOnMainThread:@selector(changeIndicatorValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForIndicatorType:componentSubtype withValue:value],[NSNumber numberWithInt:componentSubtype], nil] waitUntilDone:YES];
			 break;
		default:
			break;
	}
}

- (void) flashVerbNoun {
	verbNounVisible = !verbNounVisible;
	[self.V1Outlet setImage:[self.V1Outlet.animationImages objectAtIndex:verbNounVisible]];
	[self.V2Outlet setImage:[self.V2Outlet.animationImages objectAtIndex:verbNounVisible]];
	[self.N1Outlet setImage:[self.N1Outlet.animationImages objectAtIndex:verbNounVisible]];
	[self.N2Outlet setImage:[self.N2Outlet.animationImages objectAtIndex:verbNounVisible]];
}


- (void) triggerVerbNounFlashTimer {
	verbNounFlashTimer = [NSTimer scheduledTimerWithTimeInterval:0.666 target:self selector:@selector(flashVerbNoun) userInfo:nil repeats:YES];
}

- (void) toggleVerbNounFlashStatus:(BOOL)flash {
	if (flash){
		[self performSelectorOnMainThread:@selector(triggerVerbNounFlashTimer) withObject:nil waitUntilDone:NO];
	} else {
		[verbNounFlashTimer invalidate];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initSegmentDictionary];
}


- (void) releaseOutlets {
	self.M1Outlet = nil;
	self.M2Outlet = nil;
	
	self.V1Outlet = nil;
	self.V2Outlet = nil;
	
	self.N1Outlet = nil;
	self.N2Outlet = nil;
	
	self.CompActIndOutlet = nil;
	
	self.uplinkActivity = nil;
	self.noAttitude = nil;
	self.standBy = nil;
	self.keyRelease = nil;
	self.operationError = nil;
	self.priorityDisplay = nil;
	self.noDAP = nil;
	self.temp = nil;
	self.gimbalLock = nil;
	self.prog = nil;
	self.restart = nil;
	self.tracker = nil;
	self.alt = nil;
	self.vel = nil;
	
	
	self._r1plusminus = nil;
	self._11Outlet = nil;	
	self._12Outlet = nil;
	self._13Outlet = nil;
	self._14Outlet = nil;
	self._15Outlet = nil;
	
	self._r2plusminus = nil;
	self._21Outlet = nil;	
	self._22Outlet = nil;
	self._23Outlet = nil;
	self._24Outlet = nil;
	self._25Outlet = nil;
	
	self._r3plusminus = nil;
	self._31Outlet = nil;	
	self._32Outlet = nil;
	self._33Outlet = nil;
	self._34Outlet = nil;
	self._35Outlet = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[self releaseOutlets];
}

- (void)dealloc {
	[self releaseOutlets];
}

@end
