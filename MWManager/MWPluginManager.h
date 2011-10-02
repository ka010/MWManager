//
//  MWPluginManager.h
//  MWManager
//
//  Created by Kai Aras on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWKit/MWMetaWatch.h>
#import <MWKit/MWImageTools.h>


#define kMWStateActive 1
#define kMWStateInactive 0

@interface MWPluginManager : NSObject

@property (retain) NSMutableDictionary *pluginMap;
@property (retain) NSMutableDictionary *pluginDict;
@property (assign) id currentPlugin;
@property (assign) int state;

-(void)loadPluginsAtPath:(NSString*)path;
-(void)loadPlugins;
-(void)activate;
-(void)activatePluginForKey:(NSNumber*)button;
-(void)deactivate;


+(MWPluginManager *) sharedManager;



@end
