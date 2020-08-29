import 'package:flutter/foundation.dart';

class AppSettings {

  String apiUrl;

  AppSettings() {
    this.apiUrl = kReleaseMode ? 'prestaqi.com:81' : 'prestaqi.com:81';
  }
}