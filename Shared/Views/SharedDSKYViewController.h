//
//  SharedDSKYViewController.h
//  iAGC
//
//  Created by argaldo on 2/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateDSKYUserInterfaceDelegate.h"
#import "DSKYSimulationClient.h"


@interface SharedDSKYViewController : UIViewController <UpdateDSKYUserInterfaceDelegate> {
	DSKYSimulationClient *dskySimulationClient;

	NSMutableDictionary *segments;
	
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
	
	NSTimer *verbNounFlashTimer;
}

@property (nonatomic,strong) DSKYSimulationClient *dskySimulationClient;

@property (nonatomic,strong) IBOutlet UIImageView *M1Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *M2Outlet;

@property (nonatomic,strong) IBOutlet UIImageView *V1Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *V2Outlet;

@property (nonatomic,strong) IBOutlet UIImageView *N1Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *N2Outlet;

@property (nonatomic,strong) IBOutlet UIImageView *CompActIndOutlet;

@property (nonatomic,strong) IBOutlet UIImageView *uplinkActivity;
@property (nonatomic,strong) IBOutlet UIImageView *noAttitude;
@property (nonatomic,strong) IBOutlet UIImageView *standBy;
@property (nonatomic,strong) IBOutlet UIImageView *keyRelease;
@property (nonatomic,strong) IBOutlet UIImageView *operationError;
@property (nonatomic,strong) IBOutlet UIImageView *priorityDisplay;
@property (nonatomic,strong) IBOutlet UIImageView *noDAP;
@property (nonatomic,strong) IBOutlet UIImageView *temp;
@property (nonatomic,strong) IBOutlet UIImageView *gimbalLock;
@property (nonatomic,strong) IBOutlet UIImageView *prog;
@property (nonatomic,strong) IBOutlet UIImageView *restart;
@property (nonatomic,strong) IBOutlet UIImageView *tracker;
@property (nonatomic,strong) IBOutlet UIImageView *alt;
@property (nonatomic,strong) IBOutlet UIImageView *vel;


@property (nonatomic,strong) IBOutlet UIImageView *_r1plusminus;
@property (nonatomic,strong) IBOutlet UIImageView *_11Outlet;	
@property (nonatomic,strong) IBOutlet UIImageView *_12Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_13Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_14Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_15Outlet;

@property (nonatomic,strong) IBOutlet UIImageView *_r2plusminus;
@property (nonatomic,strong) IBOutlet UIImageView *_21Outlet;	
@property (nonatomic,strong) IBOutlet UIImageView *_22Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_23Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_24Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_25Outlet;

@property (nonatomic,strong) IBOutlet UIImageView *_r3plusminus;
@property (nonatomic,strong) IBOutlet UIImageView *_31Outlet;	
@property (nonatomic,strong) IBOutlet UIImageView *_32Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_33Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_34Outlet;
@property (nonatomic,strong) IBOutlet UIImageView *_35Outlet;

@property (nonatomic,strong) NSMutableDictionary *segments;
@property (nonatomic,strong) NSTimer *verbNounFlashTimer;

// action delegates for dsky keyboard click
- (IBAction) pressedVerb: (id) sender;
- (IBAction) pressedNoun: (id) sender;
- (IBAction) pressedEnter: (id) sender;
- (IBAction) pressedClr: (id) sender;
- (IBAction) pressedPro: (id) sender;
- (IBAction) pressedKeyRel: (id) sender;
- (IBAction) pressedPlus: (id) sender;
- (IBAction) pressedMinus: (id) sender;
- (IBAction) pressedReset: (id) sender;
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
