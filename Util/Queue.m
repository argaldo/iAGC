//
//  Queue.m
//  iAGC
//
//  Created by argaldo on 2/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Queue.h"


@implementation Queue
- (id)init {
	if (self = [super init]) {
		objects = [[NSMutableArray alloc] init];    
	}
	return self;
}
- (void)addObject:(id)object {
	[objects addObject:object];
}
- (id)takeObject { 
	id object = nil;
	if ([objects count] > 0) {
		object = [[[objects objectAtIndex:0] retain] autorelease];
		[objects removeObjectAtIndex:0];
	}
	return object;
}
@end
