//
//  DSKYUIIphoneViewController.m
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DSKYUIIphoneViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Util.h"

@implementation DSKYUIIphoneViewController

@synthesize segments;
@synthesize dskySimulationClient;
@synthesize alertView,alertMessageLabel;


@synthesize M1Outlet,M2Outlet,V1Outlet,V2Outlet,N1Outlet,N2Outlet,CompActIndOutlet,uplinkActivity,noAttitude,standBy,keyRelease,operationError,priorityDisplay,noDAP,temp,gimbalLock,prog,restart,tracker,alt,vel,_r1plusminus,_11Outlet,	_12Outlet,_13Outlet,_14Outlet,_15Outlet,_r2plusminus,_21Outlet,_22Outlet,_23Outlet,_24Outlet,_25Outlet,_r3plusminus,_31Outlet,_32Outlet,_33Outlet,_34Outlet,_35Outlet;

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
	//[segments setObject:self.self.CompActIndOutlet forKey:@"CompActInd"];
}

- (void) releaseOutlets
{	
	[self.alertView release];
	[self.alertMessageLabel release];
	
	
	[self.M1Outlet release];
	[self.M2Outlet release];
	
	[self.V1Outlet release];
	[self.V2Outlet release];
	
	[self.N1Outlet release];
	[self.N2Outlet release];
	
	[self.CompActIndOutlet release];
	
	[self.uplinkActivity release];
	[self.noAttitude release];
	[self.standBy release];
	[self.keyRelease release];
	[self.operationError release];
	[self.priorityDisplay release];
	[self.noDAP release];
	[self.temp release];
	[self.gimbalLock release];
	[self.prog release];
	[self.restart release];
	[self.tracker release];
	[self.alt release];
	[self.vel release];
	
	
	[self._r1plusminus release];
	[self._11Outlet release];	
	[self._12Outlet release];
	[self._13Outlet release];
	[self._14Outlet release];
	[self._15Outlet release];
	
	[self._r2plusminus release];
	[self._21Outlet release];	
	[self._22Outlet release];
	[self._23Outlet release];
	[self._24Outlet release];
	[self._25Outlet release];
	
	[self._r3plusminus release];
	[self._31Outlet release];	
	[self._32Outlet release];
	[self._33Outlet release];
	[self._34Outlet release];
	[self._35Outlet release];
}



- (void)viewDidUnload {
	[self releaseOutlets];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self releaseOutlets];
	[segments release];
	[dskySimulationClient release];
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
- (IBAction) pressedPlus: (id) sender{
	[self sendDSKYCode:26];
}
- (IBAction) pressedMinus: (id) sender{
	[self sendDSKYCode:27];
	[self showAlert];
}


- (void)showAlert
{
	[self.view addSubview:alertView];
	alertView.backgroundColor = [UIColor clearColor];
    alertView.center = self.view.superview.center;
    
    CALayer *viewLayer = self.alertView.layer;
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = 0.35555555;
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:0.6],
                        [NSNumber numberWithFloat:1.1],
                        [NSNumber numberWithFloat:.9],
                        [NSNumber numberWithFloat:1],
                        nil];
    animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:0.6],
                          [NSNumber numberWithFloat:0.8],
                          [NSNumber numberWithFloat:1.0], 
                          nil];    
    
    [viewLayer addAnimation:animation forKey:@"transform.scale"];
    
    [self performSelector:@selector(updateText:) withObject:@"Getting there…" afterDelay:1.0];
    [self performSelector:@selector(updateText:) withObject:@"Really…" afterDelay:2.0];
    [self performSelector:@selector(updateText:) withObject:@"Just about there…" afterDelay:3.0];
    [self performSelector:@selector(updateText:) withObject:@"Done" afterDelay:4.5];
    [self performSelector:@selector(finalUpdate) withObject:nil afterDelay:5.0];
}


- (void)updateText:(NSString *)newText
{
    self.alertMessageLabel.text = newText;
}
- (void)finalUpdate
{
    [UIView beginAnimations:@"" context:nil];
    self.alertView.alpha = 0.0;
    [UIView commitAnimations];
    [UIView setAnimationDuration:0.35];
    [self performSelector:@selector(removeAlert) withObject:nil afterDelay:0.5];
}


- (void)removeAlert
{
    [self.alertView removeFromSuperview];
    self.alertView.alpha = 1.0;
}


@end
