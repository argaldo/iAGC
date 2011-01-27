#import <Foundation/Foundation.h>

#define SEGMENT 0
#define SIGN 1
#define INDICATOR 2

@protocol UpdateDSKYUserInterfaceDelegate

- (void) updateUserInterface:(NSString **)component withValue:(int) value withComponentType:(int) componentType;

@end