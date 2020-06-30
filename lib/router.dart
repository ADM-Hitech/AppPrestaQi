import 'package:flutter/material.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Screens/AdvancePeriodic/advance_periodic.dart';
import 'package:prestaQi/Screens/ChangePassword/change_password.dart';
import 'package:prestaQi/Screens/ConfirmRequestAdvance/confirm_request_advance.dart';
import 'package:prestaQi/Screens/DetailsInvestments/details_investments.dart';
import 'package:prestaQi/Screens/IndexAuth/index_auth.dart';
import 'package:prestaQi/Screens/MyAdvances/my_advances.dart';
import 'package:prestaQi/Screens/MyInvestments/my_investments.dart';
import 'package:prestaQi/Screens/MyProfile/my_profile.dart';
import 'package:prestaQi/Screens/RecoveryPassword/recovery_password.dart';
import 'package:prestaQi/Screens/RequestAdvance/request_advance.dart';
import 'package:prestaQi/Screens/Notification/notification.dart' as NotificationScreen;
import 'package:prestaQi/Screens/SettingDeleteAccount/setting_delete_account.dart';
import 'package:prestaQi/Screens/SettingInfoAccount/setting_info_account.dart';
import 'package:prestaQi/Screens/SettingInfoApp/setting_info_app.dart';
import 'package:prestaQi/Screens/SettingSecurity/setting_security.dart';
import 'package:prestaQi/Screens/Settings/settings.dart';
import 'package:prestaQi/Screens/TechnicalSupport/technical_support.dart';

import 'Screens/Login/login.dart';

Route<dynamic> generateRoute(RouteSettings settings, UserToken userToken) {

  switch(settings.name) {
    case '/auth':
      return MaterialPageRoute<void>(builder: (context) => Login(), settings: settings);
    break;
    case '/recovery-password':
      return MaterialPageRoute<void>(builder: (context) => RecoveryPassword(), settings: settings);
    break;
    case '/change-password':
      return MaterialPageRoute<void>(builder: (context) => ChangePassword(), settings: settings);
    break;
    case '/index-auth':
      return MaterialPageRoute<void>(builder: (context) => IndexAuth(), settings: settings);
    break;
    case '/request-advance':
      return MaterialPageRoute<void>(builder: (context) => RequestAdvance(), settings: settings);
    break;
    case '/confirm-request-advance':
      return MaterialPageRoute<void>(builder: (context) => ConfirmRequestAdvance(), settings: settings);
    break;
    case '/my-advances':
      return MaterialPageRoute<void>(builder: (context) => MyAdvances(), settings: settings);
    break;
    case '/advance-periodic':
      return MaterialPageRoute<void>(builder: (context) => AdvancePeriodic(), settings: settings);
    break;
    case '/my-profile':
      return MaterialPageRoute<void>(builder: (context) => MyProfile(), settings: settings);
    break;
    case '/notification':
      return MaterialPageRoute<void>(builder: (context) => NotificationScreen.Notification(), settings: settings);
    break;
    case '/technical-support':
      return MaterialPageRoute<void>(builder: (context) => TechnicalSupport(), settings: settings);
    break;
    case '/settings':
      return MaterialPageRoute<void>(builder: (context) => Settings(), settings: settings);
    break;
    case '/setting-security':
      return MaterialPageRoute<void>(builder: (context) => SettingSecurity(), settings: settings);
    break;
    case '/setting-info-account':
      return MaterialPageRoute<void>(builder: (context) => SettingInfoAccount(), settings: settings);
    break;
    case '/setting-info-app':
      return MaterialPageRoute<void>(builder: (context) => SettingInfoApp(), settings: settings);
    break;
    case '/setting-delete-account':
      return MaterialPageRoute<void>(builder: (context) => SettingDeleteAccount(), settings: settings);
    break;
    case '/my-investments':
      return MaterialPageRoute<void>(builder: (context) => MyInvestments(), settings: settings);
    break;
    case '/details-investments':
      return MaterialPageRoute<void>(builder: (ontext) => DetailsInvestments(), settings: settings);
    break;
    default:
      return MaterialPageRoute<void>(builder: (context) => Container(child: Text(settings.name)), settings: settings);
    break;
  }
}

bool validPermision(List<String> user, String rolUser) {
  return user.firstWhere((element) => element == rolUser, orElse: () => null) != null;
}