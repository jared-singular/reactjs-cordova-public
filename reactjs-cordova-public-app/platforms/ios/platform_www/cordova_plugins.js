cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "singular_cordova_sdk.SingularCordovaSdk",
      "file": "plugins/singular_cordova_sdk/www/SingularCordovaSdk.js",
      "pluginId": "singular_cordova_sdk",
      "clobbers": [
        "cordova.plugins.SingularCordovaSdk"
      ]
    },
    {
      "id": "singular_cordova_sdk.SingularConfig",
      "file": "plugins/singular_cordova_sdk/www/SingularConfig.js",
      "pluginId": "singular_cordova_sdk",
      "clobbers": [
        "cordova.plugins.SingularCordovaSdk.SingularConfig"
      ]
    },
    {
      "id": "singular_cordova_sdk.SingularIAP",
      "file": "plugins/singular_cordova_sdk/www/SingularIAP.js",
      "pluginId": "singular_cordova_sdk",
      "clobbers": [
        "cordova.plugins.SingularCordovaSdk.SingularIAP"
      ]
    },
    {
      "id": "singular_cordova_sdk.SingularAdData",
      "file": "plugins/singular_cordova_sdk/www/SingularAdData.js",
      "pluginId": "singular_cordova_sdk",
      "clobbers": [
        "cordova.plugins.SingularCordovaSdk.SingularAdData"
      ]
    },
    {
      "id": "singular_cordova_sdk.Events",
      "file": "plugins/singular_cordova_sdk/www/Events.js",
      "pluginId": "singular_cordova_sdk",
      "clobbers": [
        "cordova.plugins.SingularCordovaSdk.Events"
      ]
    },
    {
      "id": "singular_cordova_sdk.Attributes",
      "file": "plugins/singular_cordova_sdk/www/Attributes.js",
      "pluginId": "singular_cordova_sdk",
      "clobbers": [
        "cordova.plugins.SingularCordovaSdk.Attributes"
      ]
    },
    {
      "id": "cordova-plugin-device.device",
      "file": "plugins/cordova-plugin-device/www/device.js",
      "pluginId": "cordova-plugin-device",
      "clobbers": [
        "device"
      ]
    }
  ];
  module.exports.metadata = {
    "singular_cordova_sdk": "1.0.0",
    "cordova-plugin-device": "2.1.0"
  };
});