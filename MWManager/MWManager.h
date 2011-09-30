//
//  MWManager.h
//  MWKitDemo
//
//  Created by Kai Aras on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWKit/MWKit.h>
#import <MWKit/MWMetaWatch.h>


#import "MWMailAppController.h"
#import "MWWeatherMonitor.h"

#import "JSON.h"

@interface MWManager : NSObject {
    
    SBJsonParser *parser;
    
    NSDictionary *lastNotification;
}



@property (retain) NSTimer *updateTimer;
@property (assign) BOOL isConnected;


@end
