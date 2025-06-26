import 'package:prestaqi/services/decode_jwt.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUser {
  static final PreferenceUser _instance = PreferenceUser._internal();

  factory PreferenceUser() {
    return _instance;
  }

  PreferenceUser._internal();
  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int get id {
    return _prefs.getInt('id') ?? 0;
  }

  set id(int value) {
    _prefs.setInt('id', value);
  }

  String get tokenFirebase {
    return _prefs.getString('token_firebase') ?? '';
  }

  set tokenFirebase(String value) {
    _prefs.setString('token_firebase', value);
  }

  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  int get type {
    return _prefs.getInt('type') ?? 0;
  }

  set type(int value) {
    _prefs.setInt('type', value);
  }

  String get typeName {
    return _prefs.getString('typeName') ?? '';
  }

  set typeName(String value) {
    _prefs.setString('typeName', value);
  }

  String get rEmail {
    return _prefs.getString('rEmail') ?? '';
  }

  set rEmail(String value) {
    _prefs.setString('rEmail', value);
  }

  String get rPass {
    return _prefs.getString('rPass') ?? '';
  }

  set rPass(String value) {
    _prefs.setString('rPass', value);
  }

  bool get logged {
    return DecodeJwtService.validToken(token);
  }

  set isLogind(bool value) {
    _prefs.setBool('isLogind', value);
  }

  bool get isLogind {
    return _prefs.getBool('isLogind') ?? false;
  }

  set isFixedPayments(bool value) {
    _prefs.setBool('isFixedPayments', value);
  }

  bool get isFixedPayments {
    return _prefs.getBool('isFixedPayments') ?? false;
  }

  void logout() {
    _prefs.remove('token');
    _prefs.remove('type');
    _prefs.remove('typeName');
  }
}