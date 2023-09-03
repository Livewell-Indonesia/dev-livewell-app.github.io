import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:livewell/core/log.dart';

import '../local_storage/shared_pref.dart';

class LivewellNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      SharedPref.saveFCMToken(fcmToken);
    }
    Log.info("fcm token = $fcmToken");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Log.info('Got a message whilst in the foreground!');
      Log.info('Message data: ${message.data}');
      if (message.notification != null) {
        Log.info(
            'Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMesage);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  Future<void> handleBackgroundMesage(RemoteMessage mesage) async {
    Log.info('Handling a background message ${mesage.messageId}');
  }
}
