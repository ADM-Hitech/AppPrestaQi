import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/models/register_advances.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';
import 'package:prestaqi/utils/custom_error.utils.dart';

class MyAdvancesService {
  late String apiUrl;
  late String completeApiUrl;
  late PreferenceUser pref;

  MyAdvancesService() {
    apiUrl = appService<AppSettings>().apiUrl;
    completeApiUrl = appService<AppSettings>().completeApiUrl();
    pref = PreferenceUser();
  }

  Future<RegisterAdvancesModel> getAdvances() async {
    String path = 'api/Advances/GetByAccredited/${pref.id}';
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, path) : Uri.http(apiUrl, path);

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      if (responseObject['success']) {
        return RegisterAdvancesModel.fromJson(responseObject['data']);
      }
    }

    return throw const CustomErrorUtilsException('ocurrio un error');
  }

  Future<MyProfileModel> getMyProfile() async {
    String path = 'api/Users/GetUser';
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, path) : Uri.http(apiUrl, path);

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    MyProfileModel user = MyProfileModel();

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      if (responseObject['success']) {
        user = MyProfileModel.fromJson(responseObject['data']['user']);
        user.type = responseObject['data']['type'];
        user.typeName = responseObject['data']['typeName'];
        user.urlCartaMandato = '$completeApiUrl/Users/GetCartaMandato?token=${pref.token}';
      }
    }

    return user;
  }
}