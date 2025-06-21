import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';

class RequestAdvanceService {
  late String apiUrl;
  late String completeApiUrl;
  late PreferenceUser pref;

  RequestAdvanceService() {
    apiUrl = appService<AppSettings>().apiUrl;
    completeApiUrl = appService<AppSettings>().completeApiUrl();
    pref = PreferenceUser();
  }

  Future<MyProfileModel> getMyProfile() async {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, 'api/Users/GetUser') : Uri.http(apiUrl, 'api/Users/GetUser');

    MyProfileModel user = MyProfileModel();

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      if (responseObject['success'] as bool) {
        user = MyProfileModel.fromJson(responseObject['data']['user']);
        user.type = responseObject['data']['type'];
        user.typeName = responseObject['data']['typeName'];
        user.urlCartaMandato = '$completeApiUrl/Users/GetCartaMandato?token=${pref.token}';
      }
    }

    return user;
  }

  Future<double> calculateAdvance() async  {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, 'api/Advances/CalculateAdvance') : Uri.http(apiUrl, 'api/Advances/CalculateAdvance');

    final response = await http.post(url, body: '{}', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      if (responseObject['success'] as bool) {
        return responseObject['data']['advance']['maximum_Amount'] as double;
      }

      return 1;
    }

    return 1;
  }
}