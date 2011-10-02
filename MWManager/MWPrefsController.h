//
//  MWPrefsController.h
//  MWKitDemo
//
//  Created by Kai Aras on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPluginManager.h"

#define kInterceptorDownloadURL @"http://dl.dropbox.com/u/852546/Interceptor.growlView.zip"


@interface MWPrefsController : NSObject<NSTableViewDataSource,NSTableViewDataSource> {
    IBOutlet NSButton *installInterceptorBtn;
}


-(IBAction)setupInterceptor:(id)sender;
    
@end
