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
		// Computer activity indicator
		case 0:
			if ((indicatorValue & (1<<1)) == 0) {
				return @"dsky-compacty-off.jpg";
			} else {
				return @"dsky-compacty-on.jpg";
			}
			break;
		// operator error indicator
		case 1:
			if ((indicatorValue & (1<<6)) == 0){
				return @"OprErrOff.jpg";
			} else {
				return @"OprErrOn.jpg";
			}
			break;
			
		default:
			break;
	}
	return @"";
}


@end
