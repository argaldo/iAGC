//
//  Queue.h
//  iAGC
//
//  Created by argaldo on 2/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface Queue:NSObject {
	NSMutableArray* objects;
}
- (void)addObject:(id)object;
- (id)takeObject;
@end
