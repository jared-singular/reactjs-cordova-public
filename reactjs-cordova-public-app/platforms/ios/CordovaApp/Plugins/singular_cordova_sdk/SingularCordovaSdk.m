/********* SingularCordovaSdk.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Singular/Singular.h>
#import <Singular/SingularConfig.h>
#import <Singular/SingularLinkParams.h>
#import "SingularCordovaSdk.h"

@implementation SingularCordovaSdk{
    NSString * initCallbackID;
}

static NSString * apikey;
static NSString * secret;
static NSString * _launchOptions;
static SingularCordovaSdk * instance;
+ (NSDictionary *)launchOptions { return _launchOptions; }
+ (void)setLaunchOptions:(NSDictionary *)options { _launchOptions = options; }

- (void)pluginInitialize
{
    instance = self;
}

+ (void)startSessionWithUserActivity:(NSUserActivity*)userActivity{
    [Singular startSession:apikey
                   withKey:secret
           andUserActivity:userActivity
   withSingularLinkHandler:^(SingularLinkParams * params){
        [instance handleSingularLink:params];
    }];
}

- (void)handleSingularLink: (SingularLinkParams * )params{
        NSDictionary * paramsDict = @{
            @"type": @"SingularLinkHandler",
            @"data": @{
                @"deeplink": [params getDeepLink] ? [params getDeepLink] : @"",
                @"passthrough": [params getPassthrough] ? [params getPassthrough] : @"",
                @"isDeferred": [params isDeferred] ? @YES : @NO
            }
        };
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&err]; 
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:initCallbackID];
}

- (void)handleConversionValue: (NSInteger )conversionValue{
          NSDictionary * paramsDict = @{
            @"type": @"ConversionValueUpdatedHandler",
            @"data": [NSNumber numberWithInteger:conversionValue]
        };
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&err];
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:initCallbackID];
}


- (void )createReferrerShortLink:(CDVInvokedUrlCommand*)command
{
    NSString* url = [command.arguments objectAtIndex:0];
    NSString* refName = [command.arguments objectAtIndex:1];
    NSString* refId = [command.arguments objectAtIndex:2];
    NSDictionary* passthroughParams = [command.arguments objectAtIndex:3];
    [Singular createReferrerShortLink:url
                         referrerName:refName
                           referrerId:refId
                    passthroughParams:passthroughParams
                    completionHandler:^(NSString *data, NSError *error) {
                        CDVPluginResult* pluginResult = nil;
                        if (error) {
                            NSDictionary * paramsDict = @{
                                @"type": @"OnError",
                                @"data": error.description
                            };
                            NSError * err;
                            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&err];
                            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                            CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
                            [pluginResult setKeepCallbackAsBool:YES];
                            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
                        }
                        
                        if (data) {
                            NSDictionary * paramsDict = @{
                                @"type": @"OnSuccess",
                                @"data": data
                            };
                            NSError * err;
                            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&err];
                            NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                            CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
                            [pluginResult setKeepCallbackAsBool:YES];
                            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];                        
                        }

    }];
    NSDictionary * paramsDict = @{
         @"type": @"Done",
    };
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 

}

- (void)init:(CDVInvokedUrlCommand*)command
{
    NSDictionary* singularConfigDict = [command.arguments objectAtIndex:0];
    apikey = [singularConfigDict objectForKey:@"apikey"];
    secret = [singularConfigDict objectForKey:@"secret"];
    initCallbackID = command.callbackId;

    // General Fields
    SingularConfig* singularConfig = [[SingularConfig alloc] initWithApiKey:apikey andSecret:secret];

    // Singular Links fields
    singularConfig.launchOptions = _launchOptions;
    singularConfig.supportedDomains = [singularConfigDict objectForKey:@"supportedDomains"];
    singularConfig.shortLinkResolveTimeOut = [[singularConfigDict objectForKey:@"shortLinkResolveTimeout"] longValue];
    singularConfig.singularLinksHandler = ^(SingularLinkParams * params){
        [self handleSingularLink: params];

    };

    // Global Properties fields
    NSDictionary* globalProperties = [singularConfigDict objectForKey:@"globalProperties"];
    if (globalProperties && [globalProperties count] > 0){
         for (NSDictionary* property in [globalProperties allValues]) {
             [singularConfig setGlobalProperty:[property objectForKey:@"Key"]
                                     withValue:[property objectForKey:@"Value"]
                              overrideExisting:[[property objectForKey:@"OverrideExisting"] boolValue]];
        }
    }

    // SKAN
    singularConfig.clipboardAttribution = [[singularConfigDict objectForKey:@"clipboardAttribution"] boolValue];
    singularConfig.skAdNetworkEnabled = [[singularConfigDict objectForKey:@"skAdNetworkEnabled"] boolValue];
    singularConfig.manualSkanConversionManagement = [[singularConfigDict objectForKey:@"manualSkanConversionManagement"] boolValue];
    singularConfig.conversionValueUpdatedCallback = ^(NSInteger conversionValue) {
        [self handleConversionValue: conversionValue];
 
    };

    singularConfig.waitForTrackingAuthorizationWithTimeoutInterval =
        [[singularConfigDict objectForKey:@"waitForTrackingAuthorizationWithTimeoutInterval"] intValue];

    NSString* customUserId = [singularConfigDict objectForKey:@"customUserId"];

    if (customUserId) {
        [Singular setCustomUserId:customUserId];
    }

    NSNumber* limitDataSharing = [singularConfigDict objectForKey:@"limitDataSharing"];

    if (![limitDataSharing isEqual:[NSNull null]]) {
        [Singular limitDataSharing:[limitDataSharing boolValue]];
    }

    NSNumber* sessionTimeout = [singularConfigDict objectForKey:@"sessionTimeout"];

    if (sessionTimeout >= 0) {
        [Singular setSessionTimeout:[sessionTimeout intValue]];
    }

    [Singular start:singularConfig];

    NSDictionary * paramsDict = @{
         @"type": @"InitDone",
    };
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:paramsDict options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)event:(CDVInvokedUrlCommand*)command
{
    NSString* eventName = [command.arguments objectAtIndex:0];
    [Singular event:eventName];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)eventWithArgs:(CDVInvokedUrlCommand*)command
{
    NSString* eventName = [command.arguments objectAtIndex:0];
    NSDictionary* args = [command.arguments objectAtIndex:1];
    [Singular event:eventName withArgs:args];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)revenue:(CDVInvokedUrlCommand*)command
{
    NSString* currency = [command.arguments objectAtIndex:0];
    NSNumber* amount = [command.arguments objectAtIndex:1];
    [Singular revenue:currency amount:[amount doubleValue]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)revenueWithArgs:(CDVInvokedUrlCommand*)command
{
    NSString* currency = [command.arguments objectAtIndex:0];
    NSNumber* amount = [command.arguments objectAtIndex:1];
    NSDictionary* args = [command.arguments objectAtIndex:2];
    [Singular revenue:currency amount:[amount doubleValue] withAttributes:args];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)customRevenue:(CDVInvokedUrlCommand*)command
{
    NSString* eventName = [command.arguments objectAtIndex:0];
    NSString* currency = [command.arguments objectAtIndex:1];
    NSNumber* amount = [command.arguments objectAtIndex:2];
    [Singular customRevenue:eventName currency:currency amount:[amount doubleValue]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)customRevenueWithArgs:(CDVInvokedUrlCommand*)command
{
    NSString* eventName = [command.arguments objectAtIndex:0];
    NSString* currency = [command.arguments objectAtIndex:1];
    NSNumber* amount = [command.arguments objectAtIndex:2];
    NSDictionary* args = [command.arguments objectAtIndex:3];
    [Singular customRevenue:eventName currency:currency amount:[amount doubleValue] withAttributes:args];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUninstallToken:(CDVInvokedUrlCommand*)command
{
    NSString* token = [command.arguments objectAtIndex:0];
    [Singular registerDeviceTokenForUninstall:[token dataUsingEncoding:NSUTF8StringEncoding]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)trackingOptIn:(CDVInvokedUrlCommand*)command
{
    [Singular trackingOptIn];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)trackingUnder13:(CDVInvokedUrlCommand*)command
{
    [Singular trackingUnder13];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stopAllTracking:(CDVInvokedUrlCommand*)command
{
    [Singular stopAllTracking];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)resumeAllTracking:(CDVInvokedUrlCommand*)command
{
    [Singular resumeAllTracking];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)isAllTrackingStopped:(CDVInvokedUrlCommand*)command
{
    BOOL res = [Singular isAllTrackingStopped];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res? @"true": @"false"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)limitDataSharing:(CDVInvokedUrlCommand*)command
{
    NSNumber* limitDataSharingValue = [command.arguments objectAtIndex:0];
    [Singular limitDataSharing:[limitDataSharingValue boolValue]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getLimitDataSharing:(CDVInvokedUrlCommand*)command
{
    BOOL res = [Singular getLimitDataSharing];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res? @"true": @"false"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)skanUpdateConversionValue:(CDVInvokedUrlCommand*)command
{
    NSNumber* conversionValue = [command.arguments objectAtIndex:0];
    BOOL res = [Singular skanUpdateConversionValue:[conversionValue intValue] ];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res? @"true": @"false"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)skanGetConversionValue:(CDVInvokedUrlCommand*)command
{
    NSNumber * res = [Singular skanGetConversionValue];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[res stringValue]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)setGlobalProperty:(CDVInvokedUrlCommand*)command
{
    NSString* key = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:1];
    NSNumber* overrideExisting = [command.arguments objectAtIndex:2];
    BOOL res = [Singular setGlobalProperty:key andValue:value overrideExisting:[overrideExisting boolValue]];

    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:res? @"true": @"false"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)unsetGlobalProperty:(CDVInvokedUrlCommand*)command
{
    NSString* key = [command.arguments objectAtIndex:0];
    [Singular unsetGlobalProperty:key];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)clearGlobalProperties:(CDVInvokedUrlCommand*)command
{
    [Singular clearGlobalProperties];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"ok"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)getGlobalProperties:(CDVInvokedUrlCommand*)command
{
    NSDictionary * res = [Singular getGlobalProperties];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:res options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)skanRegisterAppForAdNetworkAttribution:(CDVInvokedUrlCommand*)command
{
    [Singular skanRegisterAppForAdNetworkAttribution];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"ok" ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

- (void)setSDKVersion:(CDVInvokedUrlCommand*)command
{
    NSString* wrapper = [command.arguments objectAtIndex:0];
    NSString* version = [command.arguments objectAtIndex:1];
    [Singular setWrapperName:wrapper andVersion:version];
    CDVPluginResult*  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"ok" ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId]; 
}

@end
