import 'package:flutter/material.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/SetupService.dart';

class BaseModel extends ChangeNotifier {

  final AuthService _authService = appService<AuthService>();

  Future<UserToken> get currentUser => _authService.me();
}