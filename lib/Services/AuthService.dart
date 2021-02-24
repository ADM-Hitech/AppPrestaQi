import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:prestaQi/Models/AuthResponse.dart';
import 'package:prestaQi/Models/Login.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Utils/DecodeJWT.dart';

class AuthService {

  String apiUrl;
  Future<SharedPreferences> sPrefs = SharedPreferences.getInstance();

  AuthService() {
    this.apiUrl = appService<AppSettings>().apiUrl;
  }

  Future<bool> logged() async {
    final SharedPreferences pref = await this.sPrefs;
    String token = pref.getString('token');
    bool isLoging = pref.getBool('isLogind');

    return validToken(token, isLoging ?? false);
  }

  Future<String> getUrlDocument() async {
    final SharedPreferences pref = await this.sPrefs;
    String token = pref.getString('token');

    return '${this.apiUrl}Users/GetContract?token=$token';
  }

  Future<List<String>> getRememberUser() async {
    final SharedPreferences pref = await this.sPrefs;
    String user = pref.getString('rUser') ?? '';
    String password = pref.getString('rPass') ?? '';

    return [user, password];
  } 

  Future<void> clearRememberUser() async {
    final SharedPreferences pref = await this.sPrefs;

    pref.remove('rUser');
    pref.remove('rPass');
  }

  Future<UserToken> me() async {
    final SharedPreferences pref = await this.sPrefs;
    String token = pref.getString('token');
    var jwtObject = parseJwt(token);
    UserToken userToken = UserToken.fromJson(jwtObject);
    userToken.urlGeneralNotice = (kReleaseMode ? 'https://' : 'http://') + '${this.apiUrl}/api/Users/GetContract?token=${pref.getString('token')}';
    
    userToken.urlContratoMutuoAccredited = (kReleaseMode ? 'https://' : 'http://') + '${this.apiUrl}/api/Users/GetContratoMutuo?token=${pref.getString('token')}';
    userToken.urlCartaAvisoGeneral = (kReleaseMode ? 'https://' : 'http://') + '${this.apiUrl}/api/Users/GetCartaAvisoGeneral?token=${pref.getString('token')}';
    userToken.urlTransferDataPersonal = (kReleaseMode ? 'https://' : 'http://') + '${this.apiUrl}/api/Users/GetTransferenciaDatosPersonales?token=${pref.getString('token')}';
    userToken.urlAvisoPrivacidad = (kReleaseMode ? 'https://' : 'http://') + '${this.apiUrl}/api/Users/GetAvisoPrivacidad?token=${pref.getString('token')}';
    userToken.urlTerminosCondiciones = (kReleaseMode ? 'https://' : 'http://') + '${this.apiUrl}/api/Users/GetTerminosCondiciones?token=${pref.getString('token')}';
    userToken.uriApi = this.apiUrl;
    userToken.token = pref.getString('token');

    return userToken;
  }

  Future<AuthResponse> auth(String email, String password, bool remember) async {

    final SharedPreferences pref = await this.sPrefs;
    AuthResponse authResponse = new AuthResponse();
    LoginModel login = new LoginModel(mail: email, password: password);

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Login') : new Uri.http(this.apiUrl, '/api/Login');

    final response = await http.post(url, 
      body: login.toJson(),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      }
    );

    var objectResponse = json.decode(response.body);

    if (response.statusCode == 200 && objectResponse['success']) {
      authResponse.firstLogin = objectResponse['data']['user']['first_Login'];
      authResponse.type = objectResponse['data']['type'];
      authResponse.typeName = objectResponse['data']['typeName'];

      pref.setString('token', objectResponse['data']['token']);
      pref.setInt('type', authResponse.type);
      pref.setString('typeName', authResponse.typeName);
      pref.setBool('isLogind', true);

      if (remember) {
        pref.setString('rUser', email);
        pref.setString('rPass', password);
      }

      await this.addDeviceToUser();

      return authResponse;
    } else {
      throw(objectResponse['message']);
    }
  }

  Future<bool> logout() async {
    final SharedPreferences pref = await this.sPrefs;

    pref.remove('token');
    pref.remove('type');
    pref.remove('typeName');
    pref.remove('isLogind');

    return true;
  }

  Future<bool> isFirstLogin() async {
    final SharedPreferences pref = await this.sPrefs;

    pref.setBool('isLogind', false);

    return true;
  }

  Future<String> recoveryPassword(String email) async {
    
    LoginModel login = new LoginModel(mail: email);

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Administrative/RecoveryPassword') : new Uri.http(this.apiUrl, '/api/Administrative/RecoveryPassword');

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

  Future<AuthResponse> changePassword(String password, bool rememberUser) async {
    final SharedPreferences pref = await this.sPrefs;
    AuthResponse authResponse = new AuthResponse();
    authResponse.success = true;

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Administrative/ChangePassword') : new Uri.http(this.apiUrl, '/api/Administrative/ChangePassword');

    final response = await http.put(url, body: '{"password": "$password"}', headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success']) {
        authResponse.type = pref.getInt('type');
        authResponse.typeName = pref.getString('typeName');
        authResponse.urlNotice = '${this.apiUrl}Users/GetContract?token=${pref.getString('token')}';
        authResponse.success = true;
        pref.setBool('isLogind', true);
        if (rememberUser) {
          pref.setString('rPass', password);
        }
      }
    }

    return authResponse;
  }

  Future<void> addDeviceToUser() async {
    final SharedPreferences pref = await this.sPrefs;

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Devices') : new Uri.http(this.apiUrl, '/api/Devices');

    this.me().then((value) async {
      final response = await http.post(url, body: '{"device_id": "${pref.getString('token_device')}", "user_id": ${value.userId}, "user_type": ${value.type}}', headers: this.headers(pref));
      if (response.statusCode == 200) {
        print(response);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  Map<String, String> headers(SharedPreferences pref) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('token')}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}