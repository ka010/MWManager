//
//  KAWeatherMonitor.h
//  MWManager
//
//  Created by Kai Aras on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kKAWeatherBaseURL @"http://www.google.com/ig/api\?weather="

@interface MWWeatherMonitor : NSObject<NSXMLParserDelegate>


+(MWWeatherMonitor *) sharedMonitor;

-(NSDictionary*)currentWeather;

@property (retain) NSString *city;
@property (retain) NSMutableDictionary *weatherDict;

@end
