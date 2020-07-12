import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  
  // ignore: close_sinks
  var mesajesStreamController = new StreamController<dynamic>();
  Stream<dynamic> get messajes => mesajesStreamController.stream.asBroadcastStream();

  PushNotificationProvider() {
    this.initNotifications();
  }

  void initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((tokenDevices) {
      print('===== FCM Token ========');
      print(tokenDevices);
    });

    _firebaseMessaging.configure(
      // cuando la aplicacion esta abierta
      onMessage: (Map<String, dynamic> message) {
        print('======== ON MESSAGE ========');
        print(message);
        this.mesajesStreamController.sink.add(message);

        return;
      },
      // cuando se resiva una notifiacion
      onLaunch: (message) {
        print('======= ON LAUNCH ======');
        print(message);
        return;
      },
      //cuando la aplicacion esta cerrada
      onResume: (message) {
        print('======== ON RESUME ===========');
        print(message);
        this.mesajesStreamController.sink.add(message);

        ///evento para el click a las notificaciones
        return;
      }
    );
  }

  void dispose() {
    this.mesajesStreamController?.close();
  }

}