//
//  MWPluginProtocol.h
//  MWManager
//
//  Created by Kai Aras on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(MWPluginProtocol) 


#define kBUTTON_A 0x00
#define kBUTTON_B 0x01
#define kBUTTON_C 0x02
#define kBUTTON_D 0x03
#define kBUTTON_E 0x05
#define kBUTTON_F 0x06



/*
    Required
 */
-(NSString*)name;


/*
    Required
    
    Return YES to simply draw an image template
    Return NO to draw and provide an image buffer
 */
-(BOOL)drawsTemplate;


/*
    Required
 */
-(void)handleButtonPress:(unsigned char)button;



/*
    Required if (BOOL)drawsTemplate returns YES - otherwise implement (NSData*)imageBuffer instead
 */
-(NSImage*)template;


/*
    Required if (BOOL)drawsTemplate returns NO - otherwise implement (NSImage*)template instead
 */
-(NSData*)imageBuffer;







@end
