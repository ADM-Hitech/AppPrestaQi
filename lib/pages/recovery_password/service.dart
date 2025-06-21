import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:prestaqi/models/login.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';

class RecoveryPasswordService {
  late String apiUrl;
  late String completeApiUrl;
  late PreferenceUser pref;

  RecoveryPasswordService() {
    apiUrl = appService<AppSettings>().apiUrl;
    completeApiUrl = appService<AppSettings>().completeApiUrl();
    pref = PreferenceUser();
  }

  Future<String> recoveryPassword(String email) async {
    
    LoginModel login = LoginModel(email: email);

    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, '/api/Administrative/RecoveryPassword') : Uri.http(apiUrl, '/api/Administrative/RecoveryPassword');

    final response = await http.put(url, 
      body: login.toJsonRecoveryPassword(),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      }
    );

    var objectResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (objectResponse['success']) {
        return 'Se ha enviado a su correo la nueva contraseña';
      }

      return objectResponse['message'];
    } else {
      return 'Error al recuperar la contraseña';
    }
  }
}