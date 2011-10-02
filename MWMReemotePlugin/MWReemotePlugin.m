//
//  MWReemotePlugin.m
//  MWManager
//
//  Created by Kai Aras on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MWReemotePlugin.h"

@implementation MWReemotePlugin

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        NSLog(@"%@",[NSBundle mainBundle]);
    }
    
    return self;
}


-(BOOL)drawsTemplate{
    return YES;
}

-(NSImage *)template{
   return [[NSBundle bundleForClass:MWReemotePlugin.class]imageForResource:@"reemote.bmp"];

}

-(NSString*)name {
    return @"Reemote";
}



-(void)handleButtonPress:(unsigned char)button {
    if (button == kBUTTON_A) {
        [self sendRequestWithUrlString:@"http://ka010s-iMac.local:2323/airfoil/skip"];
    }else if (button == kBUTTON_B) {
        [self sendRequestWithUrlString:@"http://ka010s-iMac.local:2323/airfoil/play"];    
    }else if (button == kBUTTON_C) {
        [self sendRequestWithUrlString:@"http://ka010s-iMac.local:2323/airfoil/prev"];
    }else if (button == kBUTTON_D) {
        [self sendRequestWithUrlString:@"http://ka010s-iMac.local:2323/airfoil/stop"];
    }else if (button == kBUTTON_E) {
        [self sendRequestWithUrlString:@"http://ka010s-iMac.local:2323/airfoil/volDown"];
    }else if (button == kBUTTON_F) {
        [self sendRequestWithUrlString:@"http://ka010s-iMac.local:2323/airfoil/volUp"];
    }
}


-(void)sendRequestWithUrlString:(NSString*)urlString {
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [req setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];

}


@end
