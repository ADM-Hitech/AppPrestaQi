import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prestaqi/models/notification.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';
import 'package:prestaqi/utils/custom_error.utils.dart';

class NotificationService {
  late String apiUrl;
  late PreferenceUser pref;

  NotificationService() {
    apiUrl = appService<AppSettings>().apiUrl;
    pref = PreferenceUser();
  }

  Future<List<NotificationModel>> get() async {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, 'notifications') : Uri.http(apiUrl, 'notifications');

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body) as Iterable;

      return responseObject.map((item) => NotificationModel.fromJson(item)).toList();
    }
    
    throw const CustomErrorUtilsException("Ocurrio un error, por favor intentelo de nuevo mas tarde");
  }

  Future<bool> read(int id) async {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, 'notifications/read') : Uri.http(apiUrl, 'notifications/read');

    final response = await http.put(url, body: json.encode({
      "id": id.toString()
    }), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    return response.statusCode == 200;
  }

  Future<bool> disabledNotifications(List<int> id) async {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, '/api/Notifications/DisableNotification') : Uri.http(apiUrl, '/api/Notifications/DisableNotification');

    final response = await http.put(url, body: '{"NotificationIds": $id}', headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<List<NotificationModel>> getNotification() async {
    List<NotificationModel> alerts = [];

    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, '/api/Notifications') : Uri.http(apiUrl, '/api/Notifications');

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      var objectResponse = json.decode(response.body);
      if (objectResponse['success'] as bool) {
        Iterable alert = objectResponse['data'] as Iterable;
        alerts = alert.map((item) => NotificationModel.fromJson(item)).toList();
      }
    } 

    return alerts;
  }
}