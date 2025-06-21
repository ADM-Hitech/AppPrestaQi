import 'package:flutter/material.dart';
import 'package:prestaqi/models/login.model.dart';
import 'package:prestaqi/utils/validate_form.utils.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends ValideForms {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _remindMeController = BehaviorSubject<bool>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<String> get emailStream => _emailController.stream.transform(validEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validateEmpty);
  Stream<bool> get reminMeStream => _remindMeController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(bool) get changeRemindMe => _remindMeController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String get email => _emailController.value;
  String get password => _passwordController.value;
  bool get reminMe => _remindMeController.value;
  bool get loading => _loadingController.value;

  LoginBloc() {
    changeLoading(false);
    changeRemindMe(false);
  }

  LoginModel toModel() {
    return LoginModel(email: email, password: password, remember: reminMe);
  }
}