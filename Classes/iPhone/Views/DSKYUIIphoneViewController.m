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

@synthesize alertView,uplinkView,alertMessageLabel;
@synthesize uplinkDataText;
@synthesize dskyHelpImageScrollView,dskyHelpImageView;
@synthesize managedObjectContext;
@synthesize flashingSegments;

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





- (void) releaseOutlets
{	
	self.alertView = nil;
	self.alertMessageLabel = nil;
	
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
