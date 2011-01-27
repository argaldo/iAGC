//
//  AppDelegate_iPad.h
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpdateDSKYUserInterfaceDelegate.h"

@interface AppDelegate_iPad : NSObject <UIApplicationDelegate,UpdateDSKYUserInterfaceDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

