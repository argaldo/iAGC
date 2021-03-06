//
//  DSKYSimulationClient.m
//  iAGC
//
//  Created by argaldo on 8/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DSKYSimulationClient.h"
#import "Queue.h"
#include <netdb.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <fcntl.h>


@implementation DSKYSimulationClient

@synthesize delegate;

int dskyIOSocket = -1;
NSThread *dskyThread;
NSThread *uplinkThread;

int R1Sign = 0;
int R2Sign = 0;
int R3Sign = 0;

static int lastValue = 0;
static int indicatorLastValue = 0;
static int verbNounFlashing = 0;

NSString *agcSimulatorHost = @"localhost";
u_short agcSimulatorPort = 19700;
Queue *dataUplinkQueue;

- (id) initWithHost:(NSString *)host withPort:(u_short) port {
	self = [super init];
	agcSimulatorHost = host;
	agcSimulatorPort = port;
	return self;
}
 
- (id) initWithDelegate:(id) aDelegate {
	// connecting view controller delegate for updates on the user interface...
	self.delegate = aDelegate;
	dataUplinkQueue = [[Queue alloc] init];
	return self;
}

- (int) parseIOPacket:(unsigned char *) packet withChannel:(int *)channel withValue:(int *)value withIndicatorBits:(int *)indicatorBits withUBit:(int *)uBit withLeftSegmentKey:(NSString **) leftSegmentKey withRightSegmentKey:(NSString **) rightSegmentKey withSignComponent:(NSString **) sign  withSignValue:(int *) signValue {
	// Pick the channel number and value from the packet.
	if (0x00 != (0xc0 & packet[0]))
		return (1);
	if (0x40 != (0xc0 & packet[1]))
		return (1);
	if (0x80 != (0xc0 & packet[2]))
		return (1);
	if (0xc0 != (0xc0 & packet[3]))
		return (1);
	*channel = ((packet[0] & 0x1F) << 3) | ((packet[1] >> 3) & 7);
	*value = ((packet[1] << 12) & 0x7000) | ((packet[2] << 6) & 0x0FC0) | (packet[3] & 0x003F);
	*uBit = (0x20 & packet[0]);
	
	// segment characterization
	switch (*value & 0x7800){
		// 7-segment display control
		case 0x6000:
			*indicatorBits = *value;break;
		case 0x5800:    // AAAA=11
			//NSLog(@"M1,M2");
			*leftSegmentKey = @"M1";*rightSegmentKey = @"M2";break;
		case 0x5000:	// AAAA=10
			//NSLog(@"V1,V2");
			*leftSegmentKey = @"V1";*rightSegmentKey = @"V2";break;
		case 0x4800:	// AAAA=9
			//NSLog(@"N1,N2");
			*leftSegmentKey = @"N1";*rightSegmentKey = @"N2";break;
		case 0x4000:	// AAAA=8
			//NSLog(@"11");
			*leftSegmentKey = NULL;*rightSegmentKey = @"11";break;
		case 0x3800:	// AAAA=7
			//NSLog(@"12,13");
			*sign = @"R1";
			if (0 != (*value & 0x0400))
				R1Sign |= 2;
			else
				R1Sign &= ~2;  
			*signValue = R1Sign;
			*leftSegmentKey = @"12";*rightSegmentKey = @"13";
			break;
		case 0x3000:	// AAAA=6
			//NSLog(@"14,15");
			*sign = @"R1";
			if (0 != (*value & 0x0400))
				R1Sign |= 1;
			else
				R1Sign &= ~1;
			*signValue = R1Sign;    
			*leftSegmentKey = @"14";*rightSegmentKey = @"15";
			break;
		case 0x2800:	// AAAA=5
			//NSLog(@"21,22");
			*sign = @"R2";
			if (0 != (*value & 0x0400))
				R2Sign |= 2;
			else
				R2Sign &= ~2; 
			*signValue = R2Sign; 
			*leftSegmentKey = @"21"; *rightSegmentKey = @"22";
			break;
		case 0x2000:	// AAAA=4
			//NSLog(@"23,24");
			*sign = @"R2";
			if (0 != (*value & 0x0400))
				R2Sign |= 1;
			else
				R2Sign &= ~1;
			*signValue = R2Sign;
			*leftSegmentKey = @"23"; *rightSegmentKey = @"24";
			break;
		case 0x1800:	// AAAA=3
			//NSLog(@"25,31");
			*leftSegmentKey = @"25"; *rightSegmentKey = @"31";break;
		case 0x1000:	// AAAA=2	
			//NSLog(@"32,33");
			*sign = @"R3";
			if (0 != (*value & 0x0400))
				R3Sign |= 2;
			else
				R3Sign &= ~2;
			*signValue = R3Sign;
			*leftSegmentKey = @"32"; *rightSegmentKey = @"33";
			break;
		case 0x0800:	// AAAA=1
			//NSLog(@"34,35");
			*sign = @"R3";
			if (0 != (*value & 0x0400))
				R3Sign |= 1;
			else
				R3Sign &= ~1;
			*signValue = R3Sign;
			*leftSegmentKey = @"34"; *rightSegmentKey = @"35";
			break;
		default:
			// discard packet
			return (1);
	}
	
	return (0);
}

- (int) getLeftSegmentValue:(int *) value {
	return (*value >> 5) & 0x1F;;
}

- (int) getRightSegmentValue:(int *) value {
	return (*value & 0x1F);
}
	
- (void) actOnReceivedPacket:(unsigned char *) packet {
	
	// checking for packet *signature
	if (0x40 != (packet[1] & 0xc0) ||
		0x80 != (packet[2] & 0xc0) ||
		0xc0 != (packet[3] & 0xc0)) {
        NSLog(@"Packet with malformed signature");
		return;
	}
	
	int channel, value, uBit, signValue = 0;
	int indicatorBits = -1;
	NSString *leftSegmentKey, *rightSegmentKey, *sign = NULL;
	
	if ([self parseIOPacket:packet withChannel:&channel withValue:&value withIndicatorBits:&indicatorBits withUBit:&uBit withLeftSegmentKey:&leftSegmentKey withRightSegmentKey:&rightSegmentKey withSignComponent:&sign withSignValue:&signValue]){
		// discard packet
        //NSLog(@"Descarto paquete");
		return;
	}
	
	// channel = 010 ( octal ) segment value changes
	if ( channel == 8 ) {
		// calling delegate with an interpretation of the received packet as a sign, segment or indicator value change
		if ( indicatorBits != -1) {
			
			if ((indicatorBits & (1<<2)) != (indicatorLastValue & (1<<2))){
				NSString *imagen = @"VelInd";
				[self.delegate updateUserInterface:&imagen withValue:indicatorBits withComponentType:INDICATOR withComponentSubtype:5];
			}
			if ((indicatorBits & (1<<3)) != (indicatorLastValue & (1<<3))){
				NSString *imagen = @"NoAttInd";
				[self.delegate updateUserInterface:&imagen withValue:indicatorBits withComponentType:INDICATOR withComponentSubtype:6];
			}
			if ((indicatorBits & (1<<4)) != (indicatorLastValue & (1<<4))){
				NSString *imagen = @"AltInd";
				[self.delegate updateUserInterface:&imagen withValue:indicatorBits withComponentType:INDICATOR withComponentSubtype:7];
			}
			if ((indicatorBits & (1<<5)) != (indicatorLastValue & (1<<5))){
				NSString *imagen = @"GimbalLockInd";
				[self.delegate updateUserInterface:&imagen withValue:indicatorBits withComponentType:INDICATOR withComponentSubtype:8];
			}
			if ((indicatorBits & (1<<7)) != (indicatorLastValue & (1<<7))){
				NSString *imagen = @"TrackerInd";
				[self.delegate updateUserInterface:&imagen withValue:indicatorBits withComponentType:INDICATOR withComponentSubtype:9];
			}
			if ((indicatorBits & (1<<8)) != (indicatorLastValue & (1<<8))){
				NSString *imagen = @"ProgInd";
				[self.delegate updateUserInterface:&imagen withValue:indicatorBits withComponentType:INDICATOR withComponentSubtype:10];
			}
			indicatorLastValue = indicatorBits;
			
		} else {
			if ( sign != NULL )
				[self.delegate updateUserInterface:&sign withValue:signValue withComponentType:SIGN];
			if ( leftSegmentKey != NULL )
				[self.delegate updateUserInterface:&leftSegmentKey withValue:[self getLeftSegmentValue:&value] withComponentType:SEGMENT];
			if ( rightSegmentKey != NULL )
				[self.delegate updateUserInterface:&rightSegmentKey withValue:[self getRightSegmentValue:&value] withComponentType:SEGMENT];
		}
	}
	
	// channel = 011 indicator value changes
	if (channel == 9 ) {
        
        // bit 0, ISS Warning
        
		// bit 1, Light Computer Activity Lamp
		if ((value & (1<<1)) != (lastValue & (1<<1))) {
			NSString *imagen = @"CompActInd";
			[self.delegate updateUserInterface:&imagen withValue:value withComponentType:INDICATOR withComponentSubtype:0];
		} 
        
        // bit 2, Light Uplink Activity Lamp
		if ((value & (1<<2)) != (lastValue & (1<<2))){
			NSString *image = @"uplinkActivity";
			[self.delegate updateUserInterface:&image withValue:value withComponentType:INDICATOR withComponentSubtype:3];
		}
		
        // bit 3, Light Temp Caution Lamp
		if ((value & (1<<3)) != (lastValue & (1<<3))){
			NSString *image = @"tempCaution";
			[self.delegate updateUserInterface:&image withValue:value withComponentType:INDICATOR withComponentSubtype:4];
		}
        
        // bit 4, Light Keyboard Release
		if ((value & (1<<4)) != (lastValue & (1<<4))){
			NSString *image = @"keyRel";
			[self.delegate updateUserInterface:&image withValue:value withComponentType:INDICATOR withComponentSubtype:2];
		}
        
        // bit 5, Flash Verb and Noun Lamps
        if ((value & (1<<5)) != (lastValue & (1<<5))){
			if ( value & (1<<5)){
				[self.delegate toggleVerbNounFlashStatus:YES];
			} else {
				[self.delegate toggleVerbNounFlashStatus:NO];
			}
		}
        
		// bit 6, Light Operator Error Lamp
		if ((value & (1<<6)) != (lastValue & (1<<6))){
			NSString *image = @"opError";
			[self.delegate updateUserInterface:&image withValue:value withComponentType:INDICATOR withComponentSubtype:1];
		}
		
		// bit 7, spare
        // bit 8, Test Connector Outbit
        // bit 9, Caution Reset
        // bit 10, Spare
        // bit 11, Spare
        // bit 12, Engine On/Off
        // bit 13, Spare
        // bit 14, Spare
		
		//verbNounFlashing = flashStatus;
		lastValue = value;
		
	}
	
	
	// Digital downling. Telemetry.
	if (channel == 11 || channel == 28 || channel == 29 ) {
		//NSLog(@"digital downlink");
	}

	
	
}

- (void) dskyIOListener {
	
	// listens for packets suitable for dsky's interface changes
	int packetSize = 0;
	unsigned char packet[4];
	unsigned char c;
	
	struct hostent *hp;
	struct sockaddr_in sa;
	struct in_addr *ipAddress;
	
	if (dskyIOSocket == -1) {
		if ((hp = gethostbyname("localhost")) != NULL) {
			// socket inititalization
			ipAddress = (struct in_addr*)hp->h_addr_list[0];
			sa.sin_family = AF_INET;
			sa.sin_port = htons ((u_short)19700);
			sa.sin_addr.s_addr = ipAddress->s_addr;
			if ((dskyIOSocket = socket(AF_INET, SOCK_STREAM, 0))>= 0){
				// connecting the socket
				connect(dskyIOSocket,(struct sockaddr_in *) &sa, sizeof(sa));
				fcntl(dskyIOSocket,F_SETFL, O_NONBLOCK);  // make the socket non blocking	
			}
		} else {
			// Can't resolve AGC simulator host, closing socket
			close(dskyIOSocket);
		}
	}
		
	if (dskyIOSocket != -1) {
		// socket is ready, waiting for info to arrive
		for(;;){
			int reveived = recv (dskyIOSocket, (char *) &c, 1, 0);
			if (reveived != -1) {
				// checking for packet *signature
				if (0 == (0xc0 & c))
					packetSize = 0;
				
				if (packetSize != 0 || (0xc0 & c) == 0) {
					packet[packetSize++] = c;
					if (packetSize>=4) {
						// packet is suitable for DSKY
						[self actOnReceivedPacket:packet];
						packetSize = 0;
					}
				}
				
			} else {
				// No more info left
				break;
			}
		}
	}
}

- (void) uplinkDataTimer{
	// sending uplink data in a 100 ms interval
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sendUplinkData) userInfo:nil repeats:YES];
}

- (void) dskyReceiveTimer {
	// Checking DSKY socket receival buffer in a 100 ms interval
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(dskyIOListener) userInfo:nil repeats:YES];
}

- (void) launchUplinkDataTimer {
	// launching uplink Data Timer
	[self performSelectorOnMainThread:@selector(uplinkDataTimer) withObject:nil waitUntilDone:NO];
}

- (void) launchDSKYReceiveTimer {
	// launching message receival timer on main thread
	[self performSelectorOnMainThread:@selector(dskyReceiveTimer) withObject:nil waitUntilDone:NO];
}

- (void) launchDSKYThreadDelegate {
	// Launching DSKY's thread 
	
	dskyThread = [[NSThread alloc] initWithTarget:self selector:@selector(launchDSKYReceiveTimer) object:nil];
	[dskyThread start];
	
	uplinkThread = [[NSThread alloc] initWithTarget:self selector:@selector(launchUplinkDataTimer) object:nil];
	[uplinkThread start];
}

- (void) launchDSKYIOListeningThread {
	// call thread launching delegate on main thread to avoid freezing user's interface
	[self performSelectorOnMainThread:@selector(launchDSKYThreadDelegate) withObject:nil waitUntilDone:NO];
}

- (int) buildPacket: (int) channel withValue:(int) value forPacket:(unsigned char *) packet {
	if (channel < 0 || channel > 0x1ff)
		return (1);
	if (value < 0 || value > 0x7fff)
		return (1);
	if (packet == NULL)
		return (1);
	packet[0] = channel >> 3;
	packet[1] = 0x40 | ((channel << 3) & 0x38) | ((value >> 12) & 0x07);
	packet[2] = 0x80 | ((value >> 6) & 0x3F);
	packet[3] = 0xc0 | (value & 0x3F);
	// All done.
	return 0;
}

- (void) sendPacketToSimulator:(unsigned char *) packet {
	send (dskyIOSocket, packet, 4, 0);
}

- (void) sendDSKYCode:(int) code{
	unsigned char packet[4];
	// uplink channel for dsky 15 (octal)
	[self buildPacket:015 withValue:code forPacket:packet];
	[self sendPacketToSimulator:packet];
	
}

- (void) sendUplinkData {
	id firstObject = [dataUplinkQueue takeObject];
	if (firstObject != nil) {
		int code = [firstObject intValue];
		unsigned char packet[4];
		// data uplink channel
		code &= 037;
		code |= ((code << 10) | (( code ^ 037) << 5));
		[self buildPacket:0173 withValue:code forPacket:packet];
		[self sendPacketToSimulator:packet];
	}
}

- (void) sendUplinkCode:(int) code {
	[dataUplinkQueue addObject:[NSNumber numberWithInt:code]];
}


@end
