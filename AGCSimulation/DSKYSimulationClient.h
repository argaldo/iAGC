//
//  DSKYSimulationClient.h
//  iAGC
//
//  Created by argaldo on 8/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UpdateDSKYUserInterfaceDelegate.h"


@interface DSKYSimulationClient : NSObject {
	id<UpdateDSKYUserInterfaceDelegate> delegate;
}

- (id) initWithHost:(NSString *)host withPort:(u_short) port;
- (id) initWithDelegate:(id) delegate;
- (void) launchDSKYIOListeningThread;
- (void) sendDSKYCode:(int) code;
- (void) sendUplinkCode:(int) code;

@property (assign) id<UpdateDSKYUserInterfaceDelegate> delegate;

@end
