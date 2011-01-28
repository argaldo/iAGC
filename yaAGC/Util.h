//
//  Util.h
//  iAGC
//
//  Created by argaldo on 9/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Util : NSObject {

}

- (NSString *) getImageNameForSegmentValue: (int) segmentValue;
- (NSString *) getImageNameForSignValue: (int) signValue; 
- (NSString *) getImageNameForIndicatorType:(int) indicatorType withValue:(int) indicatorValue;

@end
