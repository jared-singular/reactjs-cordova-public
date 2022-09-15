cordova.define("singular_cordova_sdk.SingularConfig", function(require, exports, module) { function SingularConfig(apikey, secret) {
        this.apikey = apikey;
        this.secret = secret;
        this.sessionTimeout = -1; // default -1, uses default timeout (60s)
        this.skAdNetworkEnabled = false;
        this.manualSkanConversionManagement = false;
        this.waitForTrackingAuthorizationWithTimeoutInterval = 0;
        this.limitDataSharing = null;
        this.shortLinkResolveTimeout = 10; // default timeout 10s
        this.globalProperties = {}
        this.collectOAID = false;
        this.enableLogging = false;
        this.clipboardAttribution = false;
    }

SingularConfig.prototype.withSessionTimeoutInSec = function(sessionTimeout) {
        this.sessionTimeout = sessionTimeout;
        return this;
}

SingularConfig.prototype.withClipboardAttribution = function() {
        this.clipboardAttribution = true;
        return this;
}

SingularConfig.prototype.withCustomUserId = function(customUserId) {
    this.customUserId = customUserId;
    return this;
}

SingularConfig.prototype.withSingularLink = function(singularLinkHandler) {
    this.singularLinkHandler = singularLinkHandler;
    return this;
}

SingularConfig.prototype.withSkAdNetworkEnabled = function(skAdNetworkEnabled) {
    this.skAdNetworkEnabled = skAdNetworkEnabled;
    return this;
}

SingularConfig.prototype.withManualSkanConversionManagement = function() {
    this.manualSkanConversionManagement = true;
    return this;
}

SingularConfig.prototype.withConversionValueUpdatedHandler = function(conversionValueUpdatedHandler) {
    this.conversionValueUpdatedHandler = conversionValueUpdatedHandler;
    return this;
}

SingularConfig.prototype.withWaitForTrackingAuthorizationWithTimeoutInterval = function(waitForTrackingAuthorizationWithTimeoutInterval) {
    this.waitForTrackingAuthorizationWithTimeoutInterval = waitForTrackingAuthorizationWithTimeoutInterval;
    return this;
}

SingularConfig.prototype.withLimitDataSharing = function(shouldLimitDataSharing) {
    this.limitDataSharing = shouldLimitDataSharing;
    return this;
}

SingularConfig.prototype.withShortLinkResolveTimeout = function(shortLinkResolveTimeout) {
    this.shortLinkResolveTimeout = shortLinkResolveTimeout;
    return this;
}

SingularConfig.prototype.withGlobalProperty = function(key, value,overrideExisting) {
    this.globalProperties[key] = {"Key":key, "Value":value,"OverrideExisting":overrideExisting};
    return this;
}

SingularConfig.prototype.withOAIDCollection = function() {
    this.collectOAID = true;
    return this;
}

SingularConfig.prototype.withLoggingEnabled = function() {
    this.enableLogging = true;
    return this;
}

SingularConfig.prototype.withLogLevel = function(level) {
    this.logLevel = level;
    return this;

}

module.exports = SingularConfig;
});
