import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/DecodeJWT.dart';
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
}