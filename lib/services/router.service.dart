import 'package:flutter/material.dart';
import 'package:prestaqi/models/advance.model.dart';
import 'package:prestaqi/models/calculate_advance.model.dart';
import 'package:prestaqi/pages/advance_periodic/page.dart';
import 'package:prestaqi/pages/change_password/page.dart';
import 'package:prestaqi/pages/confirm_request_advance.dart/page.dart';
import 'package:prestaqi/pages/index_auth/page.dart';
import 'package:prestaqi/pages/login/page.dart';
import 'package:prestaqi/pages/my_advances/page.dart';
import 'package:prestaqi/pages/notification/page.dart';
import 'package:prestaqi/pages/profile/page.dart';
import 'package:prestaqi/pages/recovery_password/page.dart';
import 'package:prestaqi/pages/request_advance/page.dart';
import 'package:prestaqi/pages/setting_info_app/page.dart';
import 'package:prestaqi/pages/settings/page.dart';
import 'package:prestaqi/pages/settings_delete_account/page.dart';
import 'package:prestaqi/pages/settings_info_account/page.dart';
import 'package:prestaqi/pages/settings_security/page.dart';
import 'package:prestaqi/pages/technical_support/page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  late MaterialPageRoute page;

  switch(settings.name) {
    case 'auth':
      page = MaterialPageRoute(builder: (context) => const LoginPage(), settings: settings);
    break;
    case 'index-auth':
      page = MaterialPageRoute(builder: (context) => const IndexAuthPage(), settings: settings);
    break;
    case 'home':
    case 'request-advance':
      page = MaterialPageRoute(builder: (context) => const RequestAdvancePage(), settings: settings);
    break;
    case 'my-advances':
      page = MaterialPageRoute(builder: (context) => const MyAdvancePage(), settings: settings);
    break;
    case 'profile':
      page = MaterialPageRoute(builder: (contex) => const ProfilePage(), settings: settings);
    break;
    case 'technical-support':
      page = MaterialPageRoute(builder: (contex) => const TechnicalSupportPage(), settings: settings);
    break;
    case 'settings':
      page = MaterialPageRoute(builder: (contex) => const SettingsPage(), settings: settings);
    break;
    case 'setting-security':
      page = MaterialPageRoute(builder: (contex) => const SettingSecurityPage(), settings: settings);
    break;
    case 'setting-info-account':
      page = MaterialPageRoute(builder: (context) => const SettingInfoAccountPage(), settings: settings);
    break;
    case 'setting-info-app':
      page = MaterialPageRoute(builder: (context) => const SettingInfoAppPage(), settings: settings);
    break;
    case 'setting-delete-account':
      page = MaterialPageRoute(builder: (context) => const SettingsDeleteAccountPage(), settings: settings);
    break;
    case 'notification':
      page = MaterialPageRoute(builder: (context) => const NotificationPage(), settings: settings);
    break;
    case 'change-password':
      page = MaterialPageRoute<void>(builder: (context) => const ChangePasswordPage(), settings: settings);
    break;
    case 'confirm-request-advance':
      CalculateAdvance canculateAdvance = settings.arguments is CalculateAdvance ? settings.arguments as CalculateAdvance : CalculateAdvance(amount: 0, maximumAmount: 0);

      page = MaterialPageRoute(builder: (context) => ConfirmRequestAdvancePage(calculateAdvance: canculateAdvance), settings: settings);
    break;
    case 'recovery':
      page = MaterialPageRoute(builder: (context) => const RecoveryPasswordPage(), settings: settings);
    break;
    case 'advance-periodic':
      var childs = settings.arguments is List<AdvanceModel> ? settings.arguments : [];

      page = MaterialPageRoute<void>(builder: (context) => AdvancePeriodicPage(childs: childs as List<AdvanceModel>), settings: settings);
    break;
    default:
      page = MaterialPageRoute(builder: (context) => Text(settings.name ?? 'DEFAULT'), settings: settings);
  }

  return page;
}