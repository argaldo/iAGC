//
//  AppDelegate_iPhone.h
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "DSKYUIIphoneViewController.h"
#import "AGCSimulator.h"
#import "AppDelegate_Shared.h"

@interface AppDelegate_iPhone : AppDelegate_Shared{
	UITabBarController *tabBarController;
	DSKYUIIphoneViewController *dskyUIIPhoneViewController;
@private
	AGCSimulator *simulator;
@private
	DSKYSimulationClient *dskyClient;
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet DSKYUIIphoneViewController *dskyUIIPhoneViewController;
@property (nonatomic, retain) AGCSimulator *simulator;
@property (nonatomic, retain) DSKYSimulationClient *dskyClient;

@end

