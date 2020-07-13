import 'dart:io';

import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationService {

  String apiUrl;
  Future<SharedPreferences> sPref = SharedPreferences.getInstance();

  NotificationService() {
    this.apiUrl = appService<AppSettings>().apiUrl;
  }

  Future<bool> disabledNotification(int id) async {
    final SharedPreferences pref = await this.sPref;

    final response = await http.put('${this.apiUrl}Notifications/DisableNotification', body: '{"NotificationIds": [$id]}', headers: this.headers(pref));

    if (response.statusCode == 200) {
      return true;
    } 

    return false;
  }

  Map<String, String> headers(SharedPreferences pref) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('token')}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}