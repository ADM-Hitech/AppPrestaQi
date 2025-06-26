import 'package:flutter/material.dart';
import 'package:prestaqi/models/user_token.model.dart';
import 'package:prestaqi/pages/settings_delete_account/content.dart';
import 'package:prestaqi/pages/settings_delete_account/service.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';

class SettingsDeleteAccountPage extends StatefulWidget {
  const SettingsDeleteAccountPage({super.key});

  @override
  SettingsDeleteAccountState createState() => SettingsDeleteAccountState();
}

class SettingsDeleteAccountState extends State<SettingsDeleteAccountPage> {

  SettingsDeleteAccountService service = SettingsDeleteAccountService();
  late UserTokenModel user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    appService<AppService>().me().then((value) {
      setState(() {
        user = value;
        loading = false;
      });
    }).catchError((onError) {
      setState(() {
        loading = false;
      });
    });
  }

  void deleteMyAccount() async {
    bool accept = await appService<NavigationService>().showConfirmDeleteAccount(context) as bool;
    if (accept) {
      setState(() {
        loading = true;
      });
      
      service.deleteMyAccount(user.userId, user.type).then((value) => {
        if (value) {
          appService<AppService>().logout(),
          appService<NavigationService>().navigateTo('index-auth')
        }
      // ignore: body_might_complete_normally_catch_error
      }).catchError((onError) {
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context: context, title: 'Eliminar cuenta'),
      body: settingDeleteAccountBody(state: this),
    );
  }
}