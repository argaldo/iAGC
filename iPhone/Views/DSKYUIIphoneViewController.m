//
//  DSKYUIIphoneViewController.m
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DSKYUIIphoneViewController.h"
#import "Util.h"

@implementation DSKYUIIphoneViewController

@synthesize segments;
@synthesize dskySimulationClient;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initSegmentDictionary];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) changeValue: (NSMutableArray *) args {
	NSLog(@"intentando actualizar la interfaz");
	NSString *component = [args objectAtIndex:0];
	NSString *imageName = (NSString *)[args objectAtIndex:1];
	if ([imageName compare:@""] != NSOrderedSame)
		[[segments objectForKey:component] setImage:[UIImage imageNamed:imageName]];
}


- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType {
	NSLog(@"Recibido update!");
	switch (componentType){
		case SEGMENT:
			[self performSelectorOnMainThread:@selector(changeValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForSegmentValue:value],nil] waitUntilDone:YES];
			break;
		case SIGN:
			[self performSelectorOnMainThread:@selector(changeValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForSignValue:value],nil] waitUntilDone:YES];
			break;
		/*case INDICATOR:
			[self performSelectorOnMainThread:@selector(changeValue:) withObject:[NSMutableArray arrayWithObjects:*component,[util getImageNameForIndicatorType:0 withValue:value],nil] waitUntilDone:YES];
			break;*/
		default:
			break;
	}
}


- (void) initSegmentDictionary {
	// initializing segment dictionary
	segments = [[NSMutableDictionary alloc] init];
	[segments setObject:M1Outlet forKey:@"M1"];
	[segments setObject:M2Outlet forKey:@"M2"];
	[segments setObject:V1Outlet forKey:@"V1"];
	[segments setObject:V2Outlet forKey:@"V2"];
	[segments setObject:N1Outlet forKey:@"N1"];
	[segments setObject:N2Outlet forKey:@"N2"];
	[segments setObject:_11Outlet forKey:@"11"];
	[segments setObject:_12Outlet forKey:@"12"];
	[segments setObject:_13Outlet forKey:@"13"];
	[segments setObject:_14Outlet forKey:@"14"];
	[segments setObject:_15Outlet forKey:@"15"];
	[segments setObject:_21Outlet forKey:@"21"];
	[segments setObject:_22Outlet forKey:@"22"];
	[segments setObject:_23Outlet forKey:@"23"];
	[segments setObject:_24Outlet forKey:@"24"];
	[segments setObject:_25Outlet forKey:@"25"];
	[segments setObject:_31Outlet forKey:@"31"];
	[segments setObject:_32Outlet forKey:@"32"];
	[segments setObject:_33Outlet forKey:@"33"];
	[segments setObject:_34Outlet forKey:@"34"];
	[segments setObject:_35Outlet forKey:@"35"];
	[segments setObject:_r1plusminus forKey:@"R1"];
	[segments setObject:_r2plusminus forKey:@"R2"];
	[segments setObject:_r3plusminus forKey:@"R3"];
	//[segments setObject:CompActIndOutlet forKey:@"CompActInd"];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (void) sendDSKYCode:(int) code {
	// wrapper over DSKYSimulationClient instance
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
- (IBAction) pressedMas: (id) sender{
	[self sendDSKYCode:26];
}
- (IBAction) pressedMenos: (id) sender{
	[self sendDSKYCode:27];
}




@end
