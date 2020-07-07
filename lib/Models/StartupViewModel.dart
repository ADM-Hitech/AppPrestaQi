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
      var user = await _authService.me();

      if (user.type == 3) {
        _navigationService.navigateTo('/request-advance');
      } else if (user.type == 2) {
        _navigationService.navigateTo('/my-investments');
      } else {
        _navigationService.navigateTo('/my-profile');
      }
    } else {
      _navigationService.navigateTo('/index-auth');
    }
  }
}