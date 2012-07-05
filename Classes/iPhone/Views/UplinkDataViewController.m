    //
//  UplinkDataViewController.m
//  iAGC
//
//  Created by argaldo on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UplinkDataViewController.h"


@implementation UplinkDataViewController


- initInManagedObjectContext:(NSManagedObjectContext *) managedObjectContext
{
	if (self = [super initWithStyle:UITableViewStylePlain])
	{
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		request.entity = [NSEntityDescription entityForName:@"DSKYUplinkData" inManagedObjectContext:managedObjectContext];
		request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date_added" ascending:YES]];
		request.predicate = nil;
		request.fetchBatchSize = 20;
		
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
										   initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"MyUplinkDataCache"];
		
		self.fetchedResultsController = frc;
		self.titleKey = @"title";
	}
	return self;
}


@end
