import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prestaqi/services/preference_user.service.dart';

class PushNotificationProvider {
  late FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin localNotifications = FlutterLocalNotificationsPlugin();
  PreferenceUser pref = PreferenceUser();

  InitializationSettings initializationSettings = const InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    iOS: DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: PushNotificationProvider.onDidReceiveLocalHotification
    )
  );

  PushNotificationProvider({ StreamController<RemoteMessage>? mesajesStreamController }) {
    initNotifications(mesajesStreamController);
    localNotifications.initialize(initializationSettings);
  }

  void initNotifications(StreamController<RemoteMessage>? mesajesStreamController) async {
    await Firebase.initializeApp();

    _firebaseMessaging = FirebaseMessaging.instance;

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );

    String? tokenFirebase = await _firebaseMessaging.getToken();

    pref.tokenFirebase = tokenFirebase ?? '';

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PushNotificationProvider.showNotification(message.notification!.title ?? '', message.notification!.body ?? '', null);

      mesajesStreamController?.sink.add(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      mesajesStreamController?.sink.add(message);
    });
  }

  static Future<dynamic> onDidReceiveLocalHotification(int id, String? title, String? body, String? payload) async {
    return;
  }

  static Future<void> showNotification(String title, String message, dynamic extra) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticket'
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await PushNotificationProvider().localNotifications.show(0, title, message, platformChannelSpecifics, payload: 'item x');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
}