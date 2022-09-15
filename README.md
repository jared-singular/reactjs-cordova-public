# reactjs-cordova-public
ReactJS Sample App using Singular's Cordova Plugin

## Building a ReactJS Sample Application
1. Create an App following the guide [HERE](https://reactjs.org/docs/create-a-new-react-app.html).
2. Create the Project directory from the Terminal by running:
```bash
npx create-react-app reactjs-cordova-public-app
```
3. Once the project is created, navigate to your project folder and run the project to test:
```bash
cd reactjs-cordova-public-app
npm start
```
>**Note**
>React should start on localhost and display the ReactJS basic App. Press `^C` from terminal to exit Node. This will kill the localhost instance.

## Add Cordova to your React App
>**Note**
>In order to build the mobile platforms (iOS and Android) for your ReactJS app, you will need to use Cordova (an open-source mobile development framework). Install Cordova following the guide [HERE](https://cordova.apache.org/docs/en/latest/guide/overview/index.html).
```bash
sudo npm install -g cordova
```

## Ejecting your App
If you want to install modules that may interact with modules the React App is using, the new modules will need to know what modules React has available, and what is not available. Meaning, you need to have your React App un-abstract them. By Ejecting your App, this will stop hiding the modules and instead eject those items into your project's package.json.
>**Warning**
>This step is required to utilize the Singular Cordova plugin.
>You may need to to commit github changes prior to ejecting.

1. From your project folder run:
```bash
npm run eject
```

>**Note**
>These next 2 steps are unique to this project and may not be needed with your own app.
2. Update the App>config>paths.js
Update from `appBuild: resolveApp(buildPath)` to `appBuild: resolveApp('www')` as noted below:
```js
// config after eject: we're in ./config/
module.exports = {
  dotenv: resolveApp('.env'),
  appPath: resolveApp('.'),
  appBuild: resolveApp('www'),
  appPublic: resolveApp('public'),
  appHtml: resolveApp('public/index.html'),
```
3. Update the package.json
In your App's package.json add `"homepage":"./"` as shown below:
```json
{
  "name": "reactjs-cordova-public-app",
  "version": "0.1.0",
  "private": true,
  "homepage":"./",
  "dependencies": {...
```

## Add Cordova to the App
To add Cordova to the App, run in terminal: 
```bash
cordova create cordovareactapp com.reactjs.cordovapublic CordovaApp
```
1. Move the new `config.xml` file created in the `cordovareactapp` folder to your React App.
```bash
mv cordovareactapp/config.xml ../reactjs-cordova-public-app
```
2. Update your Index.js
See App.js
3. Update your index.html
You must add a reference to the cordova.js script before the closing body tag:
```html
    <script type="text/javascript" src="cordova.js"></script>
  </body>
</html>
```

Add the following meta tags:
```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *; img-src 'self' data: content:;"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="msapplication-tap-highlight" content="no"/>
```
## Build the App
```bash
npm run build
```

## Build iOS or Android or Browser
```bash
cordova platform add ios
cordova platform add android
cordova platform add browser
```

## To Test iOS or Android or Browser
```bash
cordova emulate ios
cordova emulate android
cordova emulate browser
```

## To Run on a Physical Device (iOS or Android)
With the device connect
```bash
cordova run ios
cordova run android
```

## To Run on a Desktop Device (Browser)
>**Note**
>This sample App does not include integration of the Singular WebSDK. But technically, you could integration the Singular Native JS WebSDk or Google TagManager integration and invoke it when the Web App starts.
```bash
cordova emulate browser
```

## Integrate the Singular SDK using the Singular SDK Cordova Plugin
Details can be found [HERE](https://support.singular.net/hc/en-us/articles/8586543222683-Singular-SDK-Integration-for-Cordova)

1. Add the Singular Plugin to the Project
From your project folder:
```bash
cordova plugin add singular_cordova_sdk
```
2. Initializing the SDK (Required)
Initialize the SDK for Mobile Apps. There are many ways to identify this, and this app uses:
```js
if(window.cordova){
      if (window.cordova.plugins.SingularCordovaSdk) {
        alert("SingularCordovaSdk Found");
        var singularConfig = new window.cordova.plugins.SingularCordovaSdk.SingularConfig(SINGULAR_SDK_KEY, SINGULAR_SDK_SECRET);
        // Used to capture deeplink from New Intent
        var linkHandler = function(data){
          var deeplink = data.deeplink;
          var passthrough = data.passthrough;
          var isDeferred = data.isDeferred;
          
          // Handle deeplink here:
          alert(deeplink);
        }
        if(devicePlatform == "iOS"){
          // Optional: Enable SKAdNetwork (in Managed Mode, see guide for more options)
          singularConfig.withSkAdNetworkEnabled(true);
        }
        
        singularConfig.withSingularLink(linkHandler); 
        window.cordova.plugins.SingularCordovaSdk.init(singularConfig);
      }...
```

>**Note**
>This app is using additional plugins:
>[cordova-device-plugin](https://cordova.apache.org/docs/en/11.x/reference/cordova-plugin-device/)

# Android Updates
## Update the Android `MainActivity.java`
1. Add Imports
```java
// Added to support Deeplinking for Singular
import singular_cordova_sdk.SingularCordovaSdk;
import android.content.Intent;
```
2. Add to MainActivity Class (See: `platforms>android>app>src>java>com>MainActivity.java`)
```java
    @Override
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        SingularCordovaSdk.handleNewIntent(intent);
    }
```
## Update the `AndroidManifest.xml`
Add the following to the Applications Activity:
>**Note**
>Do not use the `host` option with Singular. This will prohibit the dynamic nature of how our deeplinks work.
```xml
<intent-filter>
    <data android:scheme="YOUR APP SCHEME" />
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
</intent-filter>
```

# iOS Updates
## Update the iOS AppDelegate.m
See `platforms>ios>CordovaApp>Classes>AppDelegate.m`
1. Add Imports
```Obj-C
#import "SingularCordovaSdk.h"
```
2. Update Entry Points with Singular
```Obj-C
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.viewController = [[MainViewController alloc] init];
    [SingularCordovaSdk setLaunchOptions: launchOptions];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id> * _Nullable))restorationHandler{
  [SingularCordovaSdk startSessionWithUserActivity:userActivity];
  return YES;
}
```

## Update iOS Entitlements
Update both "Entitlements-Debug.plist" and "Entitlements-Release.plist"
You must set the `com.apple.developer.associated-domains` to the domain configured in Singular's Manage Domains. Your value should be something like: "YOURCUSTOMDOMAIN.sng.link" see below:

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.developer.associated-domains</key>
	<array>
		<string>applinks:YOURCUSTOMDOMAIN.sng.link</string>
	</array>
</dict>
</plist>
```



## License

[MIT License](LICENSE)
