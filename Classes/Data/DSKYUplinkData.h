//
//  DSKYUplinkData.h
//  iAGC
//
//  Created by argaldo on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface DSKYUplinkData :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uplink_data;
@property (nonatomic, retain) NSDate * dateAdded;

@end



