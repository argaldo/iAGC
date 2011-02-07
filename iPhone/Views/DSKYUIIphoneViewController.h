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
	UIView *alertView;
	UIView *uplinkView;
	UILabel *alertMessageLabel;
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
	
	IBOutlet UITextView *uplinkDataText;
	
}

@property (nonatomic,retain) NSMutableDictionary *segments;
@property (nonatomic,retain) DSKYSimulationClient *dskySimulationClient;

@property (nonatomic,retain) IBOutlet UIView *alertView;
@property (nonatomic,retain) IBOutlet UIView *uplinkView;
@property (nonatomic,retain) IBOutlet UILabel *alertMessageLabel;


@property (nonatomic,retain) IBOutlet UIImageView *M1Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *M2Outlet;

@property (nonatomic,retain) IBOutlet UIImageView *V1Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *V2Outlet;

@property (nonatomic,retain) IBOutlet UIImageView *N1Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *N2Outlet;

@property (nonatomic,retain) IBOutlet UIImageView *CompActIndOutlet;

@property (nonatomic,retain) IBOutlet UIImageView *uplinkActivity;
@property (nonatomic,retain) IBOutlet UIImageView *noAttitude;
@property (nonatomic,retain) IBOutlet UIImageView *standBy;
@property (nonatomic,retain) IBOutlet UIImageView *keyRelease;
@property (nonatomic,retain) IBOutlet UIImageView *operationError;
@property (nonatomic,retain) IBOutlet UIImageView *priorityDisplay;
@property (nonatomic,retain) IBOutlet UIImageView *noDAP;
@property (nonatomic,retain) IBOutlet UIImageView *temp;
@property (nonatomic,retain) IBOutlet UIImageView *gimbalLock;
@property (nonatomic,retain) IBOutlet UIImageView *prog;
@property (nonatomic,retain) IBOutlet UIImageView *restart;
@property (nonatomic,retain) IBOutlet UIImageView *tracker;
@property (nonatomic,retain) IBOutlet UIImageView *alt;
@property (nonatomic,retain) IBOutlet UIImageView *vel;


@property (nonatomic,retain) IBOutlet UIImageView *_r1plusminus;
@property (nonatomic,retain) IBOutlet UIImageView *_11Outlet;	
@property (nonatomic,retain) IBOutlet UIImageView *_12Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_13Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_14Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_15Outlet;

@property (nonatomic,retain) IBOutlet UIImageView *_r2plusminus;
@property (nonatomic,retain) IBOutlet UIImageView *_21Outlet;	
@property (nonatomic,retain) IBOutlet UIImageView *_22Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_23Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_24Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_25Outlet;

@property (nonatomic,retain) IBOutlet UIImageView *_r3plusminus;
@property (nonatomic,retain) IBOutlet UIImageView *_31Outlet;	
@property (nonatomic,retain) IBOutlet UIImageView *_32Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_33Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_34Outlet;
@property (nonatomic,retain) IBOutlet UIImageView *_35Outlet;

@property (nonatomic,retain) IBOutlet UITextView *uplinkDataText;



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

- (IBAction) closeUplinkDataView: (id) sender;
- (IBAction) showUplinkDataView: (id) sender;
- (IBAction) monitorTimeUplink: (id) sender;

- (IBAction) sendCustomUplinkData: (id) sender;
@end
