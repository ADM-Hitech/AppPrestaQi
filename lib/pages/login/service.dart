import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prestaqi/models/auth_response.model.dart';
import 'package:prestaqi/models/login.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';
import 'package:prestaqi/utils/custom_error.utils.dart';

class LoginService {
  late String apiUrl;
  late PreferenceUser pref;

  LoginService() {
    apiUrl = appService<AppSettings>().apiUrl;
    pref = PreferenceUser();
  }

  Future<AuthResponse> login(LoginModel login, bool remember) async {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, 'api/Login') : Uri.http(apiUrl, 'api/Login');
    AuthResponse authResponse = AuthResponse();

    final response = await http.post(url, body: login.toJson(), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    });

    var objectResponse = response.statusCode == 200 ? json.decode(response.body) : {};

    if (response.statusCode == 200 && objectResponse['success']) {
      authResponse.firstLogin = objectResponse['data']['user']['first_Login'];
      authResponse.type = objectResponse['data']['type'];
      authResponse.typeName = objectResponse['data']['typeName'];

      pref.token = objectResponse['data']['token'];
      pref.type = authResponse.type;
      pref.typeName = authResponse.typeName;
      pref.id = objectResponse['data']['user']['id'];
      pref.isFixedPayments = (objectResponse['data']['user']['typeContract']['code'] ?? '') == 'fixedpayment';

      if (remember) {
        pref.rEmail = login.email;
        pref.rPass = login.password;
      }

      await addDeviceToUser();

      return authResponse;
    } else {
      throw CustomErrorUtilsException(objectResponse['message'] ?? "Ocurrio un error, por favor intentelo de nuevo mas tarde");
    }
  }

  Future<void> addDeviceToUser() async {
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, 'Devices') : Uri.http(apiUrl, 'Devices');

    await http.post(url, body: json.encode({
      'device_id': pref.tokenFirebase,
      'user_id': pref.id,
      'user_type': pref.type
    }), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    });
  }
}