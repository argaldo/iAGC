//
//  AppDelegate_iPad.m
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppDelegate_iPad.h"

#import "AGCSimulator.h"
#import "DSKYSimulationClient.h"
#import "DSKYUIIPadViewController.h"
#import "IPadSimulationMenuController.h"
#import "DSKYUplinkData.h"

@implementation AppDelegate_iPad

#pragma mark -
#pragma mark Application lifecycle

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType {
	NSLog(@"update");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	
	// Setting default data uplink entries
	
	DSKYUplinkData *defaultMonitorTimeUplinkData = [DSKYUplinkData createDSKYUplinkDataWithTitle:@"Monitor mission time" withData:@"V16N36E" inManagedObjectContext:self.managedObjectContext];
	
	
    // Override point for customization after application launch.
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	
	if ( [preferences boolForKey:@"sim_start_preference"] ) {
		AGCSimulator *simulator = [[AGCSimulator alloc] initWithROM:[preferences stringForKey:@"core_rope"]];
		[simulator launchSimulatorThread];
	}
	
	
	/*if ( [preferences boolForKey:@"autoconnect_preference"] ) {
		NSLog(@"Lanzando DSKY thread");
		//DSKYSimulationClient *dskyClient = [[DSKYSimulationClient alloc] initWithHost:@"localhost" withPort:19700];
		DSKYSimulationClient *dskyClient = [[DSKYSimulationClient alloc] initWithDelegate:self];
		[dskyClient launchDSKYIOListeningThread];
	}*/
	UINavigationController *navcon = [[UINavigationController alloc] init];
	DSKYUIIPadViewController *dskyViewController = [[DSKYUIIPadViewController alloc] init];
	IPadSimulationMenuController *iPadSimulationMenuController = [[IPadSimulationMenuController alloc] init];
	[navcon pushViewController:iPadSimulationMenuController animated:NO];
	UISplitViewController *svc = [[UISplitViewController alloc] init];
	UINavigationController *rightNav = [[UINavigationController alloc] init];
	[rightNav pushViewController:dskyViewController animated:NO];
	svc.delegate = dskyViewController;
	svc.viewControllers = [NSArray arrayWithObjects:navcon,rightNav,nil];
	[window addSubview:svc.view];
    [window makeKeyAndVisible];
	
	[dskyViewController release];
	[iPadSimulationMenuController release];
	[navcon release];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
