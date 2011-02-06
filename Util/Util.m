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
		/*case 0:return @"7Seg-0.jpg";break;
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
		default:return @"";*/
		// off	
		case 0:return @"digit-off.jpg";break;
		// 1
		case 3:return @"digit1.jpg";break;
		// 4
		case 15:return @"digit4.jpg";break;
		// 7
		case 19:return @"digit7.jpg";break;
		// 0
		case 21:return @"digit0.jpg";break;
		// 2
		case 25:return @"digit2.jpg";break;
		// 3
		case 27:return @"digit3.jpg";break;
		// 6
		case 28:return @"digit6.jpg";break;
		// 8
		case 29:return @"digit8.jpg";break;
		// 5
		case 30:return @"digit5.jpg";break;
		// 9
		case 31:return @"digit9.jpg";break;
		default:return @"";	
			
	}
}

+ (NSString *) getImageNameForSignValue: (int) signValue {
	if (0 != (signValue & 1))
		return @"plusmin-min.jpg";
	else if (0 != (signValue & 2))
		return @"plusmin-plus.jpg";
	else
		return @"plusmin-off.jpg";
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
