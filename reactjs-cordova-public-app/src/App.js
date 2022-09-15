import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h1>ReactJS Cordova</h1>
        <h3>Device Data</h3>
        <div id="device"><p className="App-device-data">Default Text</p></div>
        
        <h3>Send Event</h3>
        <button onClick={() => {
                alert(window.device.platform);
                if (window.cordova) {
                  if(window.device.platform == "browser"){
                    alert("Web Event");
                  } else {
                    if (window.cordova.plugins.SingularCordovaSdk) {
                      alert("Sending Custom Event");
                      // Example: Report an event called View Product with event attributes
                      window.cordova.plugins.SingularCordovaSdk.eventWithArgs('Button Clicked', // Event name 
                      { // Event attributes
                      key1:"value1",
                      key2:"value2"
                      })
                    }
                  }
                  
                }
              }}
            > Send </button>

            <h3>Send Custom Revenue</h3>
        <button
              onClick={() => {
                alert(window.device.platform);
                if (window.cordova) {
                  if(window.device.platform == "browser"){
                    alert("Web Revenue Event");
                  } else {
                    if (window.cordova.plugins.SingularCordovaSdk) {
                      alert("Sending Custom Revenue Event");
                      var customEventName = "MyPurchase";
                      var currencyCode = "USD";
                      var purchaseAmount = 9.99;
                      
                      // Example: Report an event called View Product with event attributes
                      window.cordova.plugins.SingularCordovaSdk.customRevenue(
                        customEventName, // E.g. "purchase"
                        currencyCode, // E.g. "USD"
                        purchaseAmount // E.g. 3.2
                      );
                    }
                  }
                }
              }}
            >
              Send
            </button>
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;