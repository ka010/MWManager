//
//  MWManagerAppDelegate.h
//  MWManager
//
//  Created by Kai Aras on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MWKit/MWKit.h>
#import <MWKit/MWMetaWatch.h>

#import "MWManager.h"


@interface MWManagerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	IBOutlet NSMenu *statusMenu;
    //	IBOutlet SUUpdater *updater;
	
	NSStatusItem *statusItem;
    
    


}

@property (assign) IBOutlet NSWindow *window;

@end
