import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';

class SettingsDeleteAccountService {
  late String apiUrl;
  late String completeApiUrl;
  late PreferenceUser pref;

  SettingsDeleteAccountService() {
    apiUrl = appService<AppSettings>().apiUrl;
    completeApiUrl = appService<AppSettings>().completeApiUrl();
    pref = PreferenceUser();
  }

  Future<bool> deleteMyAccount(int userId, int type) async {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, 'api/Administrative/DeleteAccount') : Uri.http(apiUrl, 'api/Administrative/DeleteAccount');

    final response = await http.put(url,
    body: "{'UserId': $userId, 'Type': $type}",
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      return (responseObject['success'] as bool);
    }

    return false;
  }
}