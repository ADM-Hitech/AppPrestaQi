import 'dart:convert';
import 'dart:io';

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

    return validToken(token);
  }

  Future<UserToken> me() async {
    final SharedPreferences pref = await this.sPrefs;
    String token = pref.getString('token');
    var jwtObject = parseJwt(token);
    UserToken userToken = UserToken.fromJson(jwtObject);

    return userToken;
  }

  Future<AuthResponse> auth(String email, String password) async {

    final SharedPreferences pref = await this.sPrefs;
    AuthResponse authResponse = new AuthResponse();
    LoginModel login = new LoginModel(mail: email, password: password);

    final response = await http.post('${this.apiUrl}Login', 
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

    return true;
  }

  Future<String> recoveryPassword(String email) async {
    
    LoginModel login = new LoginModel(mail: email);

    final response = await http.put('${this.apiUrl}Administrative/RecoveryPassword', 
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

  Future<AuthResponse> changePassword(String password) async {
    final SharedPreferences pref = await this.sPrefs;
    AuthResponse authResponse = new AuthResponse();
    authResponse.success = true;

    final response = await http.put('${this.apiUrl}Administrative/ChangePassword', body: '{"password": "$password"}', headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success']) {
        authResponse.type = pref.getInt('type');
        authResponse.typeName = pref.getString('typeName');
        authResponse.success = true;
      }
    }

    return authResponse;
  }

  Map<String, String> headers(SharedPreferences pref) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('token')}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}