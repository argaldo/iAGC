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

@implementation AppDelegate_iPhone

@synthesize window;
@synthesize tabBarController;
@synthesize dskyUIIPhoneViewController;


AGCSimulator *simulator;
DSKYSimulationClient *dskyClient;

#pragma mark -
#pragma mark Application lifecycle

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType {
	NSLog(@"update");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	// Launching simulator
	
	NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
	
	if ( [preferences boolForKey:@"sim_start_preference"] ) {
		NSLog(@"Lanzando simulator thread");
		simulator = [[AGCSimulator alloc] initWithROM:[preferences stringForKey:@"core_rope"]];
		[simulator launchSimulatorThread];
	}
	
	
	if ( [preferences boolForKey:@"autoconnect_preference"] ) {
		NSLog(@"Lanzando DSKY thread");
		//DSKYSimulationClient *dskyClient = [[DSKYSimulationClient alloc] initWithHost:@"localhost" withPort:19700];
		dskyClient = [[DSKYSimulationClient alloc] initWithDelegate:dskyUIIPhoneViewController];
		[dskyClient launchDSKYIOListeningThread];
	}
	
	
	dskyUIIPhoneViewController.dskySimulationClient = dskyClient;
	
    // Override point for customization after application launch.
	[window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
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
