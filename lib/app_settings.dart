import 'package:flutter/foundation.dart';

class AppSettings {

  String apiUrl;

  AppSettings() {
    this.apiUrl = kReleaseMode ? 'prestaqi.com:81' : '52.255.138.106:81';
  }
}