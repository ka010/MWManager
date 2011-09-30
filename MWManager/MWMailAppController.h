//
//  MWMailAppController.h
//  MWKitDemo
//
//  Created by Kai Aras on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ScriptingBridge/ScriptingBridge.h>

#define kMailAppBundleID @"com.apple.mail"

@interface MWMailAppController : NSObject {

}

@property (retain) SBApplication *app;

+(MWMailAppController *) sharedController;


-(NSString*)unreadMailCount;

@end
