//
//  MWReemotePlugin.h
//  MWManager
//
//  Created by Kai Aras on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPluginProtocol.h"

@interface MWReemotePlugin : NSObject


-(void)sendRequestWithUrlString:(NSString*)urlString;

@end
