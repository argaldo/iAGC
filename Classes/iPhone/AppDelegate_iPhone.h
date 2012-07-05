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

@interface AppDelegate_iPhone : AppDelegate_Shared {
	DSKYUIIphoneViewController *dskyUIIPhoneViewController;
@private
	AGCSimulator *simulator;
@private
	DSKYSimulationClient *dskyClient;
}

@property (nonatomic, strong) IBOutlet DSKYUIIphoneViewController *dskyUIIPhoneViewController;
@property (nonatomic, strong) AGCSimulator *simulator;
@property (nonatomic, strong) DSKYSimulationClient *dskyClient;


@end

