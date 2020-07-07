import 'package:flutter/foundation.dart';

class AppSettings {

  String apiUrl;

  AppSettings() {
    this.apiUrl = kReleaseMode ? 'https://prestaqi.azurewebsites.net/service/api/' : 'https://prestaqi.azurewebsites.net/service/api/';
  }
}