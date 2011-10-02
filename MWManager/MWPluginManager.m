//
//  MWPluginManager.m
//  MWManager
//
//  Created by Kai Aras on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MWPluginManager.h"

@implementation MWPluginManager
@synthesize pluginDict,currentPlugin,state, pluginMap;

static MWPluginManager *sharedManager;


#pragma mark - Singleton

+(MWPluginManager *) sharedManager {
    if (sharedManager == nil) {
        sharedManager = [[super allocWithZone:NULL]init];
    }
    return sharedManager;
    
}



- (id)init
{
    self = [super init];
    if (self) {
        self.state = kMWStateInactive;
       
    }
    
    return self;
}



-(void)activate {
    NSLog(@"Plugin activating");
    
    if ([self.currentPlugin drawsTemplate]) {
        NSData *data =[MWImageTools imageDataForImage:[self.currentPlugin template]];
        [[MWMetaWatch sharedWatch]writeImage:data forMode:kMODE_APPLICATION];
    }
    self.state = kMWStateActive;
}


-(void)activatePluginForKey:(NSNumber *)button {
    id plugin = [self.pluginMap objectForKey:button];
    self.currentPlugin = plugin;
    [self activate];
    NSLog(@"activate %@" ,plugin);
}



-(void)deactivate {
NSLog(@"Plugin deactivating");
    
    [[MWMetaWatch sharedWatch]resetMode];
    self.state = kMWStateInactive;
}


-(void)loadPlugins {
    
    self.pluginDict = [NSMutableDictionary new];
    self.pluginMap = [NSMutableDictionary new];
    
    /*
        Load packaged plugins
     */
    [self loadPluginsAtPath:[[NSBundle mainBundle]builtInPlugInsPath]];
       

    
    /*
      Load external plugins
     */
    NSSet *applicationsPaths = [[NSSet alloc] initWithArray:NSSearchPathForDirectoriesInDomains( NSApplicationSupportDirectory,NSUserDomainMask, YES)];
    NSString *path = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/MWManager/Plugins/"];
    
    [self loadPluginsAtPath:path];
   
    
    
    
    /*
        Configure the Watch
     */
   

    
    
    self.currentPlugin = [[self.pluginDict allValues]objectAtIndex:0];
    
    
    /*
        Map the plugins to buttons
     */
    [self.pluginMap setObject:self.currentPlugin forKey:[NSNumber numberWithUnsignedChar:kBUTTON_B]];
    
    /*
        Enalble buttons
     */
    for (NSNumber *key in pluginMap.allKeys) {
        // id plugin = [self.pluginMap objectForKey:key];
        [[MWMetaWatch sharedWatch]enableButton:kMODE_IDLE index:[key charValue] type:kBUTTON_TYPE_IMMEDIATE];
    }
    
    //NSLog(@"plugins: %@ \n %@", pluginDict, pluginMap);
}






-(void)loadPluginsAtPath:(NSString*)path {
    NSFileManager *fman = [NSFileManager defaultManager];
    

    NSBundle *pluginBundle;
    Class pluginPrincipalClass;
    id pluginInstance;
    NSArray *pluginFiles = [fman contentsOfDirectoryAtPath:path error:nil];
    for (NSString * file in pluginFiles) {
        pluginBundle =[NSBundle bundleWithPath:file];
        if (pluginBundle) {
            
            pluginPrincipalClass = [pluginBundle principalClass];
            
            if (pluginPrincipalClass) {
                
                pluginInstance = [[pluginPrincipalClass alloc]init];
                
                if (pluginInstance) {
                    [self.pluginDict setObject:pluginInstance forKey:[pluginInstance name]];
                }
            }
        }       
    }

}

@end
