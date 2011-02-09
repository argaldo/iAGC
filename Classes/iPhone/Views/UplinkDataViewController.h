//
//  UplinkDataViewController.h
//  iAGC
//
//  Created by argaldo on 2/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"


@interface UplinkDataViewController : CoreDataTableViewController {

}

- initInManagedObjectContext:(NSManagedObjectContext *) managedObjectContext;

@end
