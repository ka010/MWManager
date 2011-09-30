//
//  MWPrefsController.m
//  MWKitDemo
//
//  Created by Kai Aras on 9/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MWPrefsController.h"

@implementation MWPrefsController





- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
        if (![self interceptorAvailable]) {
            [self installInterceptor];
        } 
    }
    
    return self;
}


-(void)awakeFromNib {
    if ([self interceptorAvailable]) {
        [installInterceptorBtn setTitle:@"Interceptor Installed"];
        [installInterceptorBtn setEnabled:NO];
    }else{
        [installInterceptorBtn setTitle:@"Install Interceptor..."];
        [installInterceptorBtn setEnabled:YES];
    }
}




-(IBAction)setupInterceptor:(id)sender {
    [self installInterceptor];
}



-(BOOL)interceptorAvailable {
    NSSet *applicationsPaths = [[NSSet alloc] initWithArray:NSSearchPathForDirectoriesInDomains( NSApplicationSupportDirectory,NSUserDomainMask, YES)];
    NSString *path = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/Growl/Plugins/Interceptor.growlView"];
    
    NSFileManager *fMan = [NSFileManager defaultManager];
    
    if([fMan fileExistsAtPath:path]) {
        return YES;
    }else {
        return NO;
    }

}


-(BOOL)installInterceptor {
    NSLog(@"installing Interceptor");

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kInterceptorDownloadURL]];
    
    if (data==nil) {
        NSLog(@"*** Error while downloading Interceptor");
        return NO;
    }
    
    
    NSSet *applicationsPaths = [[NSSet alloc] initWithArray:NSSearchPathForDirectoriesInDomains( NSApplicationSupportDirectory,NSUserDomainMask, YES)];
    NSString *path = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/Growl/Plugins/Interceptor.growlView.zip"];
    NSString *path1 = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/Growl/Plugins/"];
    NSString *path2 = [[[applicationsPaths allObjects]objectAtIndex:0]stringByAppendingFormat:@"/Growl/Plugins/Interceptor.growlView"];

    BOOL success = [data writeToFile:path atomically:NO];
    
    if (!success) {
        NSLog(@"*** Error while writing Interceptor download");
        return NO;
    }
    
    NSArray *args = [NSArray arrayWithObjects:path, @"-d",path1, nil];
    [NSTask launchedTaskWithLaunchPath:@"/usr/bin/unzip" arguments:args];
    
    [NSTask launchedTaskWithLaunchPath:@"/usr/bin/open" arguments:[NSArray arrayWithObjects:path2, nil]];

    [NSTask launchedTaskWithLaunchPath:@"/bin/rm" arguments:[NSArray arrayWithObjects:path, nil]];

    
    return YES;
}

@end
