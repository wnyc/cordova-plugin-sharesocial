//
//  Social.m
//
//  Cameron Lerch
//  Sponsored by Brightflock: http://brightflock.com
//

#import "ShareSocial.h"

@interface ShareSocial ()

@end

@implementation ShareSocial

- (void)available:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = nil;
    if (NSClassFromString(@"UIActivityViewController")) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Share not supported on < iOS6"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)share:(CDVInvokedUrlCommand*)command {
    // check that sharing is supported
    CDVPluginResult* pluginResult = nil;
    if (!NSClassFromString(@"UIActivityViewController")) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Share not supported on < iOS6"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
    // retrieve parameter information
    NSString * subject = nil;
    NSString *  text = nil;
    NSDictionary  * info = [command.arguments  objectAtIndex:0];
    if (info!=nil) {
        subject = [info valueForKey:@"subject"];
        text = [info valueForKey:@"text"];
        
    }
    
    // configure and launch activity
    NSArray *activityItems = [[NSArray alloc] initWithObjects:text, nil];
    UIActivity *activity = [[UIActivity alloc] init];
    NSArray *applicationActivities = [[NSArray alloc] initWithObjects:activity, nil];
    UIActivityViewController *activityVC =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    [activityVC setValue:subject forKey:@"subject"];
    [self.viewController presentViewController:activityVC animated:YES completion:nil];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
