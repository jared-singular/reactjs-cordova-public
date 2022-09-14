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

From your project folder run:
```bash
npm run eject
```


## License

[MIT License](LICENSE)
