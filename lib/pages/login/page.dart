import 'package:flutter/material.dart';
import 'package:prestaqi/pages/login/bloc.dart';
import 'package:prestaqi/pages/login/content.dart';
import 'package:prestaqi/pages/login/service.dart';
import 'package:prestaqi/providers/notification.provider.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {

  PreferenceUser pref = PreferenceUser();
  LoginBloc bloc = LoginBloc();
  LoginService service = LoginService();

  @override
  void initState() {
    super.initState();

    Future.microtask(() => {
      bloc.changeEmail(pref.rEmail),
      bloc.changePassword(pref.rPass),
      bloc.changeRemindMe(pref.rEmail != '' && pref.rPass != ''),
      bloc.emailController.text = pref.rEmail,
      bloc.passwordController.text = pref.rPass
    });
  }

  void submit() {
    Provider.of<NotificationProvider>(context, listen: false);

    bloc.changeLoading(true);

    service.login(bloc.toModel(), bloc.reminMe).then((value) {
      if (value.firstLogin) {
        appService<NavigationService>().navigateToAndRemoveHistory('change-password', arguments: bloc.reminMe);

        return;  
      }

      appService<NavigationService>().navigateToAndRemoveHistory('home');
    }).onError((Exception error, stackTrace) {
      bloc.changeLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: loginBody(state: this),
    );
  }
}