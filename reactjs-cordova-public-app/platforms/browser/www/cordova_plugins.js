cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/cordova-plugin-device/www/device.js",
        "id": "cordova-plugin-device.device",
        "pluginId": "cordova-plugin-device",
        "clobbers": [
            "device"
        ]
    },
    {
        "file": "plugins/cordova-plugin-device/src/browser/DeviceProxy.js",
        "id": "cordova-plugin-device.DeviceProxy",
        "pluginId": "cordova-plugin-device",
        "runs": true
    },
    {
        "file": "plugins/singular_cordova_sdk/www/SingularCordovaSdk.js",
        "id": "singular_cordova_sdk.SingularCordovaSdk",
        "pluginId": "singular_cordova_sdk",
        "clobbers": [
            "cordova.plugins.SingularCordovaSdk"
        ]
    },
    {
        "file": "plugins/singular_cordova_sdk/www/SingularConfig.js",
        "id": "singular_cordova_sdk.SingularConfig",
        "pluginId": "singular_cordova_sdk",
        "clobbers": [
            "cordova.plugins.SingularCordovaSdk.SingularConfig"
        ]
    },
    {
        "file": "plugins/singular_cordova_sdk/www/SingularIAP.js",
        "id": "singular_cordova_sdk.SingularIAP",
        "pluginId": "singular_cordova_sdk",
        "clobbers": [
            "cordova.plugins.SingularCordovaSdk.SingularIAP"
        ]
    },
    {
        "file": "plugins/singular_cordova_sdk/www/SingularAdData.js",
        "id": "singular_cordova_sdk.SingularAdData",
        "pluginId": "singular_cordova_sdk",
        "clobbers": [
            "cordova.plugins.SingularCordovaSdk.SingularAdData"
        ]
    },
    {
        "file": "plugins/singular_cordova_sdk/www/Events.js",
        "id": "singular_cordova_sdk.Events",
        "pluginId": "singular_cordova_sdk",
        "clobbers": [
            "cordova.plugins.SingularCordovaSdk.Events"
        ]
    },
    {
        "file": "plugins/singular_cordova_sdk/www/Attributes.js",
        "id": "singular_cordova_sdk.Attributes",
        "pluginId": "singular_cordova_sdk",
        "clobbers": [
            "cordova.plugins.SingularCordovaSdk.Attributes"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-device": "2.1.0",
    "singular_cordova_sdk": "1.0.0"
}
// BOTTOM OF METADATA
});