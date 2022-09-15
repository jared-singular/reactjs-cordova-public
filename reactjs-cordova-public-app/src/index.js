import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

var app = {
  initialize: function(){
    document.addEventListener('deviceready',app.onDeviceReady, false);
    ReactDOM.render(<App />, document.getElementById('root'));
  },
  onDeviceReady: function(){
    var devicePlatform = window.device.platform;
    var deviceData = document.querySelector('#device p');
    if(devicePlatform == "browser"){
      alert("Initialize SingularWebSDK");
      deviceData.innerHTML = "Cordova Version: " + window.device.cordova + '<br/>' +
                             "Device Platform: " + window.device.platform + '<br/>' +
                             "Device Model: " + window.device.model + '<br/>';
    } else if(window.cordova){
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
      } else alert("SingularCordovaSdk plugins not found");
      deviceData.innerHTML = "Cordova Version: " + window.device.cordova + '<br/>' +
                             "Device Platform: " + window.device.platform + '<br/>' +
                             "Device Model: " + window.device.model + '<br/>' +
                             "Device Make: " + window.device.manufacturer + '<br/>' +
                             "Device UUID: " + window.device.uuid + '<br/>' +
                             "Device isVirtual: " + window.device.isVirtual + '<br/>';
    } else { deviceData.innerHTML = "Unsupported Device";}
  }
};

app.initialize();

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
