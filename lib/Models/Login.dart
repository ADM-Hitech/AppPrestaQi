import 'dart:convert';

class LoginModel {
  String mail;
  String password;

  LoginModel({this.mail, this.password});

  String toJson() => json.encode({
    'mail': mail,
    'password': password
  });

  String toJsonRecoveryPassword() => json.encode({
    'mail': mail
  });
}