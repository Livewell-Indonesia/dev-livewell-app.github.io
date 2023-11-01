import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:livewell/core/log.dart';
import 'package:livewell/feature/dashboard/domain/usecase/register_device_token.dart';
import 'package:livewell/main.dart';

import '../local_storage/shared_pref.dart';

class LivewellNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  RegisterDevice registerDevice = RegisterDevice.instance();

  final _androidChannel = const AndroidNotificationChannel('high_importance_chanel', 'High Importance Notifications',
      description: 'This channel is used for important notifications', importance: Importance.defaultImportance);

  Future<void> initToken() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      SharedPref.saveFCMToken(fcmToken);
      Log.info("fcm token = $fcmToken");
    }
  }

  Future<void> handleTermintated() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      handleMessage(message);
    }
  }

  Future<void> init() async {
    await initToken();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessage(message);
    });
    await initLocalNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Log.info('Got a message whilst in the foreground!');
      Log.info('Message data: ${message.data}');
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(_androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description, importance: Importance.max, priority: Priority.high, showWhen: false, icon: '@drawable/ic_livewell_notification'),
          ),
          payload: jsonEncode(message.toMap()));

      if (message.notification != null) {
        handleMessage(message);
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      Log.info("fcm token refresh = $event");
      SharedPref.saveFCMToken(event);
      final result = await registerDevice(event);
      result.fold((l) {}, (r) {});
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        handleMessage(message);
      }
    });
  }

  void handleMessage(RemoteMessage message) {
    final payload = message.data['data'];
    inspect(payload);
    if (payload != null) {
      final decodedPayload = jsonDecode(payload) as Map<String, dynamic>;
      if (decodedPayload['type'] != null) {
        mapPayloadToRoute(decodedPayload['type']);
      }
    }
  }

  Future<void> handleBackgroundMesage(RemoteMessage mesage) async {
    Log.info('Handling a background message ${mesage.messageId}');
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_livewell_notification');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          handleMessage(RemoteMessage.fromMap(jsonDecode(details.payload!)));
        }
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}
