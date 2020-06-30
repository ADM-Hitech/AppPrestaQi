import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prestaQi/Models/BaseModel.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';

class StartupViewModel extends BaseModel {

  final AuthService _authService = appService<AuthService>();
  final NavigationService _navigationService = appService<NavigationService>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  Future handleStartUpLogin() async {

    var hasLoggedInUser = await _authService.logged();

    if (hasLoggedInUser) {
      _navigationService.navigateTo('/home');
    } else {
      _navigationService.navigateTo('/index-auth');
    }
  }
}