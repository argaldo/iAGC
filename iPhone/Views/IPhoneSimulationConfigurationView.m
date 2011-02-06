//
//  IPhoneSimulationConfigurationView.m
//  iAGC
//
//  Created by argaldo on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IPhoneSimulationConfigurationView.h"
#import "MTStatusBarOverlay.h"


@implementation IPhoneSimulationConfigurationView

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];   
	overlay.animation = MTStatusBarOverlayAnimationFallDown;  // MTStatusBarOverlayAnimationShrink
	overlay.detailViewMode = MTDetailViewModeHistory;      // enable automatic history-tracking and show in detail-view
	overlay.delegate = self;
	[overlay postMessage:@"Following @myell0w on Twitter..."]; 
	// ...
	[overlay postMessage:@"Following myell0w on Github..." animated:NO];  
	// ...
	[overlay postImmediateFinishMessage:@"Following was a good idea!" duration:20.0 animated:YES];
}


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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end