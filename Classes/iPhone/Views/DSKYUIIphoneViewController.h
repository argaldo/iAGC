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

@property (nonatomic,strong) NSArray *flashingSegments;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic,strong) IBOutlet UIView *alertView;
@property (nonatomic,strong) IBOutlet UIViewController *uplinkView;
@property (nonatomic,strong) IBOutlet UILabel *alertMessageLabel;


@property (nonatomic,strong) IBOutlet UITextView *uplinkDataText;
@property (nonatomic,strong) IBOutlet UIScrollView *dskyHelpImageScrollView;
@property (nonatomic,strong) IBOutlet UIImageView *dskyHelpImageView;



- (IBAction) closeUplinkDataView: (id) sender;
- (IBAction) showUplinkDataView: (id) sender;
- (IBAction) monitorTimeUplink: (id) sender;

- (IBAction) sendCustomUplinkData: (id) sender;
- (IBAction) setCurrentTime: (id) sender;
@end
