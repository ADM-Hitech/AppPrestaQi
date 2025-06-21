import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestaqi/models/notification.model.dart';
import 'package:prestaqi/providers/notification.provider.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/notification.service.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:provider/provider.dart';

class StartupViewModel extends ChangeNotifier {

  final PreferenceUser _prefs = PreferenceUser();
  final NavigationService _navigationService = appService<NavigationService>();
  final NotificationService notificationService = NotificationService();

  Future<void> handleStartUp(BuildContext context) async {
    bool loggedUser = _prefs.logged;
    final pNotification = Provider.of<NotificationProvider>(context, listen: false);

    try {
      List<NotificationModel> notification = await notificationService.get();
      for (var element in notification) {
        pNotification.addAlert(element);
      }
    } catch (_) {}

    if (loggedUser) {
      _navigationService.navigateToAndRemoveHistory('request-advance', arguments: true);
    } else {
      _navigationService.navigateToAndRemoveHistory('index-auth', arguments: true);
    }

    Timer.periodic(const Duration(seconds: 1), (timer) {      
      String? currentPath;
      _navigationService.navigationKey.currentState?.popUntil((route) {
        currentPath = route.settings.name;
        return true;
      });

      if (!_prefs.logged && currentPath != null && currentPath != 'auth' && currentPath != 'index-auth' && currentPath != 'recovery' && currentPath != 'register') {
        try {
          pNotification.clearAlert();
        } catch (_) {}
        
        _navigationService.navigateToAndRemoveHistory('auth');
      }
    });
  }
}