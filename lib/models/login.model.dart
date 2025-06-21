import 'dart:convert';

class LoginModel {

  late String email;
  late String password;
  late bool remember;
  late String tokenFirebase;
  late String model;
  late String platform;
  late String deviceVersion;

  LoginModel({
    this.email = '',
    this.password = '',
    this.remember = false,
    this.tokenFirebase = '',
    this.platform = '',
    this.deviceVersion = '',
    this.model = ''
  });

  String toJson() => json.encode({
    'mail': email.replaceAll(RegExp(r"\s+"), ''),
    'password': password,
    'token_firebase': tokenFirebase,
    'platform': platform,
    'device_version': deviceVersion,
    'model': model
  });

  String toJsonRecoveryPassword() => json.encode({
    'mail': email.replaceAll(RegExp(r"\s+"), ''),
  });
}