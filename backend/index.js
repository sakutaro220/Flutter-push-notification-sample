var admin = require("firebase-admin");

var serviceAccount = require("PATH_TO_SERVICE_ACCOUNT_JSON");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

var message = {
  data: {
    key1: 'value1',
    key2: 'value2'
  },
  token: "YOUR_FIREBASE_DEVICE_TOKEN"
};

admin.messaging().send(message)
  .then((response) => {
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });