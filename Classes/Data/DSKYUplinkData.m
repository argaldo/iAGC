// 
//  DSKYUplinkData.m
//  iAGC
//
//  Created by argaldo on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DSKYUplinkData.h"


@implementation DSKYUplinkData 

@dynamic title;
@dynamic uplink_data;
@dynamic date_added;


+ (DSKYUplinkData * )createDSKYUplinkDataWithTitle:(NSString *) title withData:(NSString *) uplinkData inManagedObjectContext:(NSManagedObjectContext *) managedObjectContext
{
	DSKYUplinkData *data = nil;
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"DSKYUplinkData" inManagedObjectContext:managedObjectContext];
	request.predicate = [NSPredicate predicateWithFormat:@"title = %@",title];
	NSError *error;
	data = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];
	if (!error & !data)
	{
		data = [NSEntityDescription insertNewObjectForEntityForName:@"DSKYUplinkData" inManagedObjectContext:managedObjectContext];
		data.title = title;
		data.uplink_data = uplinkData;
		data.date_added = [NSDate date];
	}
	[request release];
	return data;
}

@end
