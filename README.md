## Setting up and initializing Firebase Cloud Messaging (FCM)
1. Access the Firebase Console and create a project.
https://console.firebase.google.com/

2. Navigate to the settings page of the project you created in the Firebase Console and download `GoogleService-Info.plist`.

3. Place the downloaded `GoogleService-Info.plist` in the `ios/Runner` directory of your Flutter project.

4. Perform Capability settings.
https://firebase.flutter.dev/docs/messaging/apple-integration#configuring-your-app

5. Link APNs with FCM.
https://developer.apple.com/account/resources/certificates/list



## How to test push notification
### Checking push notifications on a real device
There is no problem if you run it from XCode with the real device connected.

### Testing Foreground messages:
You can send a test notification for Foreground from the Firebase Console.

### Testing Background Messages:
There is code in the `backend` folder that sends data using the admin sdk.

1. Access the Firebase Console.
https://console.firebase.google.com/

2. Navigate to the settings page of the project you created and download `serviceAccountKey.json`.

3. Place the downloaded `serviceAccountKey.json` in the `backend` directory.

4. Modify the following part in `backend/index.js`:

`PATH_TO_SERVICE_ACCOUNT_JSON`

`YOUR_FIREBASE_DEVICE_TOKEN`

5. Run the following command at `backend` folder:
```
yarn && yarn start
```