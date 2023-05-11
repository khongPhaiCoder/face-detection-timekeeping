import FCM from 'fcm-node';

var serverKey =
  'AAAAKlqgvWA:APA91bH81gHsQnesQQ9LBEMKlzoPOWZbJpiycZpo5AYw4brZXpEYItBfxaT6pfVyKt_1j8vzBuDBzKxpe6rZnFjuyp-hPQGn0eSi_5Oi22RbG91bUCc1cvnONQnwt9go7lQ0tb01PSq3';
var fcm = new FCM(serverKey);

function sendNotification(message) {
  fcm.send(message, function (err, response) {
    if (err) {
      console.log('Something has gone wrong!' + err);
      console.log('Respponse:! ' + response);
    } else {
      // showToast("Successfully sent with response");
      console.log('Successfully sent with response: ', response);
    }
  });
}

export { sendNotification };
