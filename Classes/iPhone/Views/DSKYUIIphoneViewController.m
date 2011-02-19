//
//  DSKYUIIphoneViewController.m
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DSKYUIIphoneViewController.h"
#import "UplinkDataViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Util.h"

@implementation DSKYUIIphoneViewController

@synthesize segments;
@synthesize dskySimulationClient;
@synthesize alertView,uplinkView,alertMessageLabel;
@synthesize uplinkDataText;
@synthesize dskyHelpImageScrollView,dskyHelpImageView;
@synthesize managedObjectContext;


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initSegmentDictionary];
	self.uplinkView = [[UplinkDataViewController alloc] initInManagedObjectContext:self.managedObjectContext];
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
	NSString *component = [args objectAtIndex:0];
	NSString *imageName = (NSString *)[args objectAtIndex:1];
	if ([imageName compare:@""] != NSOrderedSame)
		[[segments objectForKey:component] setImage:[UIImage imageNamed:imageName]];
}

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType {
	[self updateUserInterface:component withValue:value withComponentType:componentType withComponentSubtype:0];
}

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType withComponentSubtype:(int) componentSubtype{
	switch (componentType){
		case SEGMENT:
			[self performSelectorOnMainThread:@selector(changeValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForSegmentValue:value],nil] waitUntilDone:YES];
			break;
		case SIGN:
			[self performSelectorOnMainThread:@selector(changeValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForSignValue:value],nil] waitUntilDone:YES];
			break;
		case INDICATOR:
			[self performSelectorOnMainThread:@selector(changeValue:) withObject:[NSMutableArray arrayWithObjects:*component,[Util getImageNameForIndicatorType:componentSubtype withValue:value],nil] waitUntilDone:YES];
			break;
		default:
			break;
	}
}


- (void) releaseOutlets
{	
	self.alertView = nil;
	self.alertMessageLabel = nil;
	
	
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
	
	self.uplinkDataText = nil;
	self.dskyHelpImageScrollView = nil;
	self.dskyHelpImageView = nil;
	
	self.uplinkView = nil;
	
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

- (void) sendUplinkCode:(int) code {
	// wrapper over DSKYSimulationClient instance to send uplink data
	[dskySimulationClient sendUplinkCode:code];
}

- (void) sendDSKYCode:(int) code {
	// wrapper over DSKYSimulationClient instance to send dsky data
	[dskySimulationClient sendDSKYCode:code];
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.dskyHelpImageView;
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

- (void) parseUplinkDataString: (NSString *) uplinkData {
	int tam = [uplinkData length];
	int code;
	for (int i=0;i<tam;i++){
		switch([uplinkData characterAtIndex:i]) {
			case 'V': code = 17;break;
			case 'N': code = 31;break;
			case '1': code = 1;break;
			case '2': code = 2;break;
			case '3': code = 3;break;
			case '4': code = 4;break;
			case '5': code = 5;break;
			case '6': code = 6;break;
			case '7': code = 7;break;
			case '8': code = 8;break;
			case '9': code = 9;break;
			case '0': code = 16;break;
			case 'E': code = 28;break;
			case '+': code = 26;break;
		}
		[self sendUplinkCode:code];
	}
}

- (IBAction) pressedMinus: (id) sender{
	[self sendDSKYCode:27];
	//[self showAlert];
}

- (IBAction) pressedReset: (id) sender{
	[self sendDSKYCode:18];
}


- (IBAction) sendCustomUplinkData: (id) sender{
	[self parseUplinkDataString:[self.uplinkDataText text]];
}

- (IBAction) monitorTimeUplink: (id) sender {
	[self parseUplinkDataString:@"V16N36E"];
}

- (IBAction) setCurrentTime: (id) sender {
	NSDate *now = [NSDate date];
	NSDateFormatter *date_formatter=[[NSDateFormatter alloc]init];
	[self parseUplinkDataString:@"V25N36E+000"];
	[date_formatter setDateFormat:@"HH24"];
	[self parseUplinkDataString:[date_formatter stringFromDate:now]];
	[self parseUplinkDataString:@"E+000"];
	[date_formatter setDateFormat:@"mm"];
	[self parseUplinkDataString:[date_formatter stringFromDate:now]];
	[self parseUplinkDataString:@"E+0"];
	[date_formatter setDateFormat:@"ss"];
	[self parseUplinkDataString:[date_formatter stringFromDate:now]];
	[self parseUplinkDataString:@"00E"];
	[date_formatter release];
}

- (IBAction) showUplinkDataView: (id) sender {
	[self presentModalViewController:self.uplinkView animated:YES];
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
