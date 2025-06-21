import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';

class ProfileService {
  late String apiUrl;
  late String completeApiUrl;
  late PreferenceUser pref;

  ProfileService() {
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
}