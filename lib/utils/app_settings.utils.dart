import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class AppSettings {
  late String apiUrl;
  late bool envProd;

  StreamController<RemoteMessage> messajesStreamController = StreamController<RemoteMessage>();
  Stream<RemoteMessage> get messajes => messajesStreamController.stream.asBroadcastStream();

  AppSettings() {
    apiUrl = 'prestaqi.com:81';
    envProd = true;
  }

  String completeApiUrl() {
    return 'http${envProd ? 's' : '' }://$apiUrl/api';
  }
}