//
//  AppDelegate_iPhone.h
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DSKYUIIphoneViewController.h"

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	DSKYUIIphoneViewController *dskyUIIPhoneViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet DSKYUIIphoneViewController *dskyUIIPhoneViewController;

@end

