//
//  DSKYUIIphoneViewController.h
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpdateDSKYUserInterfaceDelegate.h"
#import "DSKYSimulationClient.h"


@interface DSKYUIIphoneViewController : UIViewController <UpdateDSKYUserInterfaceDelegate>{
	
	DSKYSimulationClient *dskySimulationClient;
@private	
	NSMutableDictionary *segments;
	
	// segment display outlets
	
	
	IBOutlet UIImageView *M1Outlet;
	IBOutlet UIImageView *M2Outlet;
	
	IBOutlet UIImageView *V1Outlet;
	IBOutlet UIImageView *V2Outlet;
	
	IBOutlet UIImageView *N1Outlet;
	IBOutlet UIImageView *N2Outlet;
	
	IBOutlet UIImageView *CompActIndOutlet;
	
	IBOutlet UIImageView *uplinkActivity;
	IBOutlet UIImageView *noAttitude;
	IBOutlet UIImageView *standBy;
	IBOutlet UIImageView *keyRelease;
	IBOutlet UIImageView *operationError;
	IBOutlet UIImageView *priorityDisplay;
	IBOutlet UIImageView *noDAP;
	IBOutlet UIImageView *temp;
	IBOutlet UIImageView *gimbalLock;
	IBOutlet UIImageView *prog;
	IBOutlet UIImageView *restart;
	IBOutlet UIImageView *tracker;
	IBOutlet UIImageView *alt;
	IBOutlet UIImageView *vel;
	
	
	IBOutlet UIImageView *_r1plusminus;
	IBOutlet UIImageView *_11Outlet;	
	IBOutlet UIImageView *_12Outlet;
	IBOutlet UIImageView *_13Outlet;
	IBOutlet UIImageView *_14Outlet;
	IBOutlet UIImageView *_15Outlet;
	
	IBOutlet UIImageView *_r2plusminus;
	IBOutlet UIImageView *_21Outlet;	
	IBOutlet UIImageView *_22Outlet;
	IBOutlet UIImageView *_23Outlet;
	IBOutlet UIImageView *_24Outlet;
	IBOutlet UIImageView *_25Outlet;
	
	IBOutlet UIImageView *_r3plusminus;
	IBOutlet UIImageView *_31Outlet;	
	IBOutlet UIImageView *_32Outlet;
	IBOutlet UIImageView *_33Outlet;
	IBOutlet UIImageView *_34Outlet;
	IBOutlet UIImageView *_35Outlet;
	
}

@property (nonatomic,retain) NSMutableDictionary *segments;
@property (nonatomic,retain) DSKYSimulationClient *dskySimulationClient;


// action delegates for dsky keyboard click
- (IBAction) pressedVerb: (id) sender;
- (IBAction) pressedNoun: (id) sender;
- (IBAction) pressedEnter: (id) sender;
- (IBAction) pressedClr: (id) sender;
- (IBAction) pressedPro: (id) sender;
- (IBAction) pressedKeyRel: (id) sender;
- (IBAction) pressedPlus: (id) sender;
- (IBAction) pressedMinus: (id) sender;
- (IBAction) pressed1: (id) sender;
- (IBAction) pressed2: (id) sender;
- (IBAction) pressed3: (id) sender;
- (IBAction) pressed4: (id) sender;
- (IBAction) pressed5: (id) sender;
- (IBAction) pressed6: (id) sender;
- (IBAction) pressed7: (id) sender;
- (IBAction) pressed8: (id) sender;
- (IBAction) pressed9: (id) sender;
- (IBAction) pressed0: (id) sender;

@end
