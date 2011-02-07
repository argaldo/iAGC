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

@implementation AppDelegate_iPad

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType {
	NSLog(@"update");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
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


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
