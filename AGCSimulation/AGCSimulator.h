//
//  AGCSimulator.h
//  iAGC
//
//  Created by argaldo on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AGCSimulator : NSObject {
@private
	NSThread *simulatorThread;
@private
	NSString *coreRopeROM;
}

@property (nonatomic,retain) NSThread *simulatorThread;
@property (nonatomic,retain) NSString *coreRopeROM;

- (id) initWithROM:(NSString *)rom;
- (void) launchSimulatorThread;
- (void) stopSimulationThread;
- (BOOL) isSimulationRunning;

@end
