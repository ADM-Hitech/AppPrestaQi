import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Models/Alert.dart';

class NotificationService {

  String apiUrl;
  Future<SharedPreferences> sPref = SharedPreferences.getInstance();

  NotificationService() {
    this.apiUrl = appService<AppSettings>().apiUrl;
  }

  Future<bool> disabledNotification(int id) async {
    final SharedPreferences pref = await this.sPref;

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Notifications/DisableNotification') : new Uri.http(this.apiUrl, '/api/Notifications/DisableNotification');

    final response = await http.put(url, body: '{"NotificationIds": [$id]}', headers: this.headers(pref));

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> disabledNotifications(List<int> ids) async {
    final SharedPreferences pref = await this.sPref;

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Notifications/DisableNotification') : new Uri.http(this.apiUrl, '/api/Notifications/DisableNotification');

    final response = await http.put(url, body: '{"NotificationIds": $ids}', headers: this.headers(pref));

    if (response.statusCode == 200) {
      return true;
    } 

    return false;
  }

  Future<List<Alert>> getNotification() async {
    final SharedPreferences pref = await this.sPref;
    List<Alert> alerts = new List<Alert>();

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Notifications') : new Uri.http(this.apiUrl, '/api/Notifications');

    final response = await http.get(url, headers: this.headers(pref));

    if (response.statusCode == 200) {
      var objectResponse = json.decode(response.body);
      if (objectResponse['success'] as bool) {
        Iterable alert = objectResponse['data'] as Iterable;
        alerts = alert.map((item) => Alert.fromJson(item)).toList();
      }
    } 

    return alerts;
  }

  Map<String, String> headers(SharedPreferences pref) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('token')}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}