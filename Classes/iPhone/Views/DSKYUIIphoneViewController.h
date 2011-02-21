//
//  DSKYUIIphoneViewController.h
//  iAGC
//
//  Created by argaldo on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpdateDSKYUserInterfaceDelegate.h"
#import "SharedDSKYViewController.h"
#import "DSKYSimulationClient.h"


@interface DSKYUIIphoneViewController : SharedDSKYViewController <UIScrollViewDelegate>{
	UIView *alertView;
	UIViewController *uplinkView;
	UILabel *alertMessageLabel;
	NSManagedObjectContext *managedObjectContext;
@private	

	NSArray *flashingSegments;
	
	// segment display outlets
	
	
	IBOutlet UITextView *uplinkDataText;
	IBOutlet UIScrollView *dskyHelpImageScrollView;
	IBOutlet UIImageView *dskyHelpImageView;
	
}

@property (nonatomic,retain) NSArray *flashingSegments;
@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic,retain) IBOutlet UIView *alertView;
@property (nonatomic,retain) IBOutlet UIViewController *uplinkView;
@property (nonatomic,retain) IBOutlet UILabel *alertMessageLabel;


@property (nonatomic,retain) IBOutlet UITextView *uplinkDataText;
@property (nonatomic,retain) IBOutlet UIScrollView *dskyHelpImageScrollView;
@property (nonatomic,retain) IBOutlet UIImageView *dskyHelpImageView;



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
- (IBAction) setCurrentTime: (id) sender;
@end
