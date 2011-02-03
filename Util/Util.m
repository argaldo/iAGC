//
//  Util.m
//  iAGC
//
//  Created by argaldo on 9/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Util.h"


@implementation Util

+ (NSString *) getImageNameForSegmentValue: (int) segmentValue {
	switch(segmentValue){
		case 0:return @"7Seg-0.jpg";break;
		case 3:return @"7Seg-3.jpg";break;
		case 15:return @"7Seg-15.jpg";break;
		case 19:return @"7Seg-19.jpg";break;
		case 21:return @"7Seg-21.jpg";break;
		case 25:return @"7Seg-25.jpg";break;
		case 27:return @"7Seg-27.jpg";break;
		case 28:return @"7Seg-28.jpg";break;
		case 29:return @"7Seg-29.jpg";break;
		case 30:return @"7Seg-30.jpg";break;
		case 31:return @"7Seg-31.jpg";break;
		default:return @"";
	}
}

+ (NSString *) getImageNameForSignValue: (int) signValue {
	if (0 != (signValue & 1))
		return @"MinusOn.jpg";
	else if (0 != (signValue & 2))
		return @"PlusOn.jpg";
	else
		return @"PlusMinusOff.jpg";
}

+ (NSString *) getImageNameForIndicatorType:(int) indicatorType withValue:(int) indicatorValue {
	switch(indicatorType){
		case 0:
			if ((indicatorValue & 2) == 0) {
				return @"CompActyOff.jpg";
			} else {
				return @"CompActyOn.jpg";
			}
			break;
		default:
			break;
	}
	return @"";
}


@end
