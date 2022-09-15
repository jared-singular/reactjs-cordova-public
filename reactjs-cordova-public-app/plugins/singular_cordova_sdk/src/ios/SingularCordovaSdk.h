#import <Cordova/CDV.h>
@interface SingularCordovaSdk : CDVPlugin {
  // Member variables go here.
  
}
@property (class) NSDictionary *launchOptions;

- (void)init:(CDVInvokedUrlCommand*)command;
- (void)createReferrerShortLink:(CDVInvokedUrlCommand*)command;
- (void)event:(CDVInvokedUrlCommand*)command;
- (void)eventWithArgs:(CDVInvokedUrlCommand*)command;
- (void)revenue:(CDVInvokedUrlCommand*)command;
- (void)revenueWithArgs:(CDVInvokedUrlCommand*)command;
- (void)customRevenue:(CDVInvokedUrlCommand*)command;
- (void)customRevenueWithArgs:(CDVInvokedUrlCommand*)command;
- (void)setUninstallToken:(CDVInvokedUrlCommand*)command;
- (void)trackingOptIn:(CDVInvokedUrlCommand*)command;
- (void)trackingUnder13:(CDVInvokedUrlCommand*)command;
- (void)stopAllTracking:(CDVInvokedUrlCommand*)command;
- (void)resumeAllTracking:(CDVInvokedUrlCommand*)command;
- (void)isAllTrackingStopped:(CDVInvokedUrlCommand*)command;
- (void)getLimitDataSharing:(CDVInvokedUrlCommand*)command;
- (void)skanUpdateConversionValue:(CDVInvokedUrlCommand*)command;
- (void)skanGetConversionValue:(CDVInvokedUrlCommand*)command;
- (void)setGlobalProperty:(CDVInvokedUrlCommand*)command;
- (void)unsetGlobalProperty:(CDVInvokedUrlCommand*)command;
- (void)clearGlobalProperties:(CDVInvokedUrlCommand*)command;
- (void)getGlobalProperties:(CDVInvokedUrlCommand*)command;
- (void)skanRegisterAppForAdNetworkAttribution:(CDVInvokedUrlCommand*)command;
- (void)setSDKVersion:(CDVInvokedUrlCommand*)command;
- (void)pluginInitialize;
+ (void)startSessionWithUserActivity:(NSUserActivity*)userActivity;







@end
