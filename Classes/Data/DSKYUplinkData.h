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

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uplink_data;
@property (nonatomic, strong) NSDate *date_added;

+ (DSKYUplinkData * )createDSKYUplinkDataWithTitle:(NSString *) title withData:(NSString *) uplinkData inManagedObjectContext:(NSManagedObjectContext *) managedObjectContext;

@end



