import FCM from 'fcm-node';

var serverKey =
  'AAAAKlqgvWA:APA91bEWrns3PwcGfc2Jbb_uskEZGS6lV3iCQPhD1ls6Wod15_KYkicR8Yb_4knCoazJOmlaTt-rskVyxl6NKtqLxrOEG6EeMIQTFC_NL69Jkoho-Z6eVWn0fQjtttTsoNrQxDemCVZb';
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
