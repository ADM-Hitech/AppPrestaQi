import 'package:flutter/foundation.dart';

class AppSettings {

  String apiUrl;

  AppSettings() {
    this.apiUrl = kReleaseMode ? 'https://api-prestaqi.com' : 'http://localhost:455/';
  }
}