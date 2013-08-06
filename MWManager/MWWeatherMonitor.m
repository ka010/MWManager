//
//  KAWeatherMonitor.m
//  MWManager
//
//  Created by Kai Aras on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MWWeatherMonitor.h"

@implementation MWWeatherMonitor
@synthesize weatherDict,city;

static MWWeatherMonitor *sharedMonitor;


#pragma mark - Singleton

+(MWWeatherMonitor *) sharedMonitor {
    if (sharedMonitor == nil) {
        sharedMonitor = [[super allocWithZone:NULL]init];
    }
    return sharedMonitor;
    
}



- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.weatherDict = [NSMutableDictionary  new];
        self.city=@"Stuttgart";
    }
    
    return self;
}




-(NSDictionary*)currentWeather {
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",kKAWeatherBaseURL,self.city,kKAWeatherEndURL]];
    NSData *d = [NSData dataWithContentsOfURL:url];
    NSString *dataString = [[NSString alloc]initWithData:d encoding:NSISOLatin1StringEncoding];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    [parser setShouldProcessNamespaces:YES];
     [parser setShouldResolveExternalEntities:YES];
    [parser setShouldReportNamespacePrefixes:YES];
    [parser setDelegate:self];
    [parser parse];
      NSLog(@"weather: %@",self.weatherDict);
    [parser release];
     return weatherDict;
}



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    //  NSLog(@"element: %@ %@",elementName, attributeDict);
     id obj = [attributeDict objectForKey:@"data"];
    if (obj) {
        [self.weatherDict setObject:obj forKey:elementName];
    }
    
}


@end
