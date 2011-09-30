//
//  MWMailAppController.m
//  MWKitDemo
//
//  Created by Kai Aras on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MWMailAppController.h"

@implementation MWMailAppController

static MWMailAppController *sharedController;

@synthesize app;

#pragma mark - Singleton

+(MWMailAppController *) sharedController {
    if (sharedController == nil) {
        sharedController = [[super allocWithZone:NULL]init];
    }
    return sharedController;
    
}



- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
       self.app = [SBApplication applicationWithBundleIdentifier:kMailAppBundleID];

    }
    
    return self;
}


-(NSString*)unreadMailCount {
    return [NSString stringWithFormat:@"%i",[[self.app inbox]unreadCount]];
}

-(void)dealloc {
    [app release];
}
@end
