//
//  MWManagerAppDelegate.m
//  MWManager
//
//  Created by Kai Aras on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MWManagerAppDelegate.h"

@implementation MWManagerAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    if (![[ NSUserDefaults standardUserDefaults]boolForKey:@"runbefore"]) {
        [self setupPreferences];
    }
    
    
    /*
     Subscribe to MWKit Notifications
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mwDidOpenChannel:) name:MWKitDidOpenChannelNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mwDidCloseChannel:) name:MWKitDidCloseChannelNotification object:nil];
    
    
    /*
     Setup the System Menu
     */
    statusItem = [[[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength]retain];
	[statusItem setMenu:statusMenu];
	[statusItem setHighlightMode:YES];
	[statusItem setImage:[NSImage imageNamed:@"mwm.png"]];
	[self updateSystemMenu];
    
    
    /*
        Start the Manager
     */
    [MWManager new];
    
        
}



/*
 Local Notifications
 */
-(void)mwDidOpenChannel:(NSNotification*)aNotification {
    
    [statusItem setImage:[NSImage imageNamed:@"mwm2.png"]];
}

-(void)mwDidCloseChannel:(NSNotification*)aNotification {
    
    [statusItem setImage:[NSImage imageNamed:@"mwm.png"]];
    
}










#pragma mark - System Menu Handler


-(void)handleSystemMenuEvent:(NSMenuItem *)item {
	switch ([item tag]) {
		case 0:
            //   [updater checkForUpdates:self];
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btAddr"]length]>0) {
                [[MWMetaWatch sharedWatch]openChannelWithAddressString:[[NSUserDefaults standardUserDefaults]objectForKey:@"btAddr"]];
            }else {
                [[MWMetaWatch sharedWatch]startSearch];
            }

            
			break;
		case 1:
			//[prefPanel makeKeyAndOrderFront:self];
            [[MWMetaWatch sharedWatch]close];
            
			break;
		case 2:
            [NSApp activateIgnoringOtherApps:YES];
			[self.window orderFront:self];
			break;
		case 3:
			exit(0);
			break;
            
		default:
			//multiModeActive=NO;
			//[self setServiceName:[item title]];
			[self updateSystemMenu];
			break;
	}
	
}






#pragma mark - Setup

-(void)updateSystemMenu {
	id element;
	
	for (NSMenuItem *i in [statusMenu itemArray]) {
		[statusMenu removeItem:i];
	}
	
	
    /*	[item setTitle:@"Address:"];
     [item setEnabled:NO];
     [statusMenu addItem:item];
     
     // seperator
     item =[NSMenuItem separatorItem];
     [statusMenu addItem:item];
     */	
    
    
    NSMenuItem *item = [[NSMenuItem alloc]init];
	[item setTitle:@"Connect..."];
	[item setTag:0];
	[item setEnabled:YES];
	[item setAction:@selector(handleSystemMenuEvent:)];
	[statusMenu addItem:item];
	[item release];
    
    item = [[NSMenuItem alloc]init];
	[item setTitle:@"Disconnect"];
	[item setTag:1];
	[item setEnabled:YES];
	[item setAction:@selector(handleSystemMenuEvent:)];
	[statusMenu addItem:item];
	[item release];
	
    
    // seperator
    item =[NSMenuItem separatorItem];
    [statusMenu addItem:item];
	//*
	//* Updates
	//*
	// seperator
	//item =[NSMenuItem separatorItem];
	//[statusMenu addItem:item];
	
    //	item = [[NSMenuItem alloc]init];
    //	[item setTitle:@"Check for Updates..."];
    //	[item setTag:0];
    //	[item setEnabled:YES];
    //	[item setAction:@selector(handleSystemMenuEvent:)];
    //	[statusMenu addItem:item];
    //	[item release];
	
    
    
    //*
	//* Preferences
	//*
	
    item = [[NSMenuItem alloc]init];
    [item setTitle:@"Preferences..."];
    [item setTag:2];
    [item setEnabled:YES];
    [item setAction:@selector(handleSystemMenuEvent:)];
    [statusMenu addItem:item];
    
	
    //	item = [[NSMenuItem alloc]init];
    //	[item setTitle:@"Online Help..."];
    //	[item setTag:2];
    //	[item setEnabled:YES];
    //	[item setAction:@selector(handleSystemMenuEvent:)];
    //	[statusMenu addItem:item];
    //    [item release];
    //	
    //	[statusMenu addItem:[NSMenuItem separatorItem]];
	
	
	item = [[NSMenuItem alloc]init];
	[item setTitle:@"Quit"];
	[item setTag:3];
	[item setEnabled:YES];
	[item setAction:@selector(handleSystemMenuEvent:)];
	[statusMenu addItem:item];
	[item release];
	
	
	
}

-(void) applicationWillTerminate:(NSNotification *)notification {
	[[MWMetaWatch sharedWatch]close];
}




-(void)setupPreferences {
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"updateIdleScreen"];
    [[NSUserDefaults standardUserDefaults]setFloat:60.0 forKey:@"updateIdleScreenInterval"];
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"buzzNotifications"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"enableNotifications"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"enableNotificationReplay"];

    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"enableAutoConnect"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"enableAutoReConnect"];

    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"btAddr"];
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"runbefore"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
