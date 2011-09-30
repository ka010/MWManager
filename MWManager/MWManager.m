//
//  MWManager.m
//  MWKitDemo
//
//  Created by Kai Aras on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MWManager.h"

@implementation MWManager
@synthesize isConnected;
@synthesize updateTimer;

- (id)init
{
    self = [super init];
    if (self) {
        
        parser = [SBJsonParser new];
        self.isConnected=NO;
        
        
        /*
         Subscribe to MWKit Notifications
         */
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mwDidOpenChannel:) name:MWKitDidOpenChannelNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mwDidCloseChannel:) name:MWKitDidCloseChannelNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mwDidReceiveData:) name:MWKitDidReceiveData object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mwDidSendData:) name:MWKitDidSendData object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mwDidReceiveButtonPress:) name:MWKitDidReceivePuttonPress object:nil];
        
        
        /*
         Subscribe to Interceptor Notications
         */
        [[NSDistributedNotificationCenter defaultCenter]addObserver:self 
                                                           selector:@selector(mwmDidReceiveNotification:) 
                                                               name:@"InterceptorGrowlNotification" 
                                                             object:nil];
        
        
        /*
         Setup Weather 
         */
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"weatherCity"]) {
            [[MWWeatherMonitor sharedMonitor]setCity:[[NSUserDefaults standardUserDefaults]objectForKey:@"weatherCity"]];
        }
        
        
        
        /*
         Setup a global Timer
         */
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"updateIdleScreen"]) {
            self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:[[NSUserDefaults standardUserDefaults]floatForKey:@"updateIdleScreenInterval"] target:self selector:@selector(update) userInfo:nil repeats:YES]; 
        }
        
        
        

        
        /*
         Init the Watch
         */
        [MWMetaWatch sharedWatch].connectionController = [MWBluetoothController sharedController];
        
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"enableAutoConnect"]) {
            [[MWMetaWatch sharedWatch]openChannelWithAddressString:[[NSUserDefaults standardUserDefaults]objectForKey:@"btAddr"]];
        }

    }
    
    return self;
}






#pragma mark - Timer

-(void)update {
    
    if (self.isConnected) {
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:[[MWMailAppController sharedController]unreadMailCount] forKey:@"pushcount"];
        [dict setObject:@"1" forKey:@"phonecount"];
        [dict setObject:@"2" forKey:@"tweetcount"];
        
        [dict setObject:[[MWWeatherMonitor sharedMonitor]currentWeather] forKey:@"weatherDict"];
        
        [[MWMetaWatch sharedWatch]writeIdleScreenWithData:dict];
        
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"enableNotificationReplay"]) {
            [[MWMetaWatch sharedWatch]enableButton:kMODE_IDLE index:kBUTTON_A type:kBUTTON_TYPE_IMMEDIATE];
        }
    }
}



#pragma mark - Notifications 


/*
 *  Distributed Notifications
 */
-(void)mwmDidReceiveNotification:(NSNotification*)aNotification {
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"enableNotifications"]) {
        return;
    }
    
    
    NSLog(@"%@",[aNotification object]);
    NSDictionary *dict = (NSDictionary*)[parser objectWithString:[aNotification object]];
    
    if (self.isConnected) {
        
        
        [[MWMetaWatch sharedWatch]writeNotification:[dict objectForKey:@"title"] 
                                        withContent:[dict objectForKey:@"text"]
                                         fromSource:[dict objectForKey:@"src"]];
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"buzzNotifications"]) {
            [[MWMetaWatch sharedWatch]buzz];
        }
        
        [self performSelector:@selector(update) withObject:nil afterDelay:15.0];
    }
    
    
    lastNotification = [dict retain];
}



-(void)replayNotification{
    if (self.isConnected) {
        
        [[MWMetaWatch sharedWatch]updateDisplay:kMODE_NOTIFICATION];
        [[MWMetaWatch sharedWatch]performSelector:@selector(resetMode) withObject:nil afterDelay:5.0];
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"buzzNotifications"]) {
            [[MWMetaWatch sharedWatch]buzz];
        }
        
    }
    
}


/*
 Local Notifications
 */
-(void)mwDidOpenChannel:(NSNotification*)aNotification {
    self.isConnected=YES;
    [self update];
}

-(void)mwDidCloseChannel:(NSNotification*)aNotification {
    self.isConnected=NO;
        
}

-(void)mwDidReceiveData:(NSNotification*)aNotification {
}

-(void)mwDidSendData:(NSNotification*)aNotification {
}

-(void)mwDidReceiveButtonPress:(NSNotification*)aNotification {
    NSLog(@"Button %@ pressed",[aNotification object]);
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"enableNotificationReplay"]) {
        [self replayNotification];
    }
}


@end
