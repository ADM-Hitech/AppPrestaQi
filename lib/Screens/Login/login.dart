import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/Login/login_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

import '../../Services/AuthService.dart';
import '../../Services/SetupService.dart';

class Login extends StatefulWidget {
  
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String error = '';
  ScreenResponsive screen;
  bool loading = false;
  bool rememberUser = true;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.getRememberUser();
  }

  void getRememberUser() async {
    appService<AuthService>().getRememberUser().then((value) {
      setState(() {
        this.emailController.text = value[0];
        this.passwordController.text = value[1];
      });
    }).catchError((onError) {});
  }

  void lowerCaseEmail(String email) {
    setState(() {
      this.emailController.text = email.toLowerCase();
    });
  }
  
  String validateUser(String value) {
    if (value.isEmpty) {
      return 'Ingrese un usuario';
    }

    return null;
  }

  void updateRememberUser(bool value) {
    setState(() {
      this.rememberUser = value;
    });

    if (!this.rememberUser) {
      appService<AuthService>().clearRememberUser().then((value) { }).catchError((onError) {});
    }
  }

  void submit() async {

    if (this.formKey.currentState.validate()) {
      try {
        setState(() {
          this.loading = true;
        });

        String emailClean = this.emailController.text.replaceAll(new RegExp(r"\s+"), '');

        appService<AuthService>().auth(emailClean, this.passwordController.text, this.rememberUser).then((value) {
          if (value.firstLogin) {
            //appService<NavigationService>().showContract(context, value.contract);
            appService<NavigationService>().navigateTo('/change-password', arguments: this.rememberUser);
          } else {
            if (value.type == 3) {
              appService<NavigationService>().navigateTo('/request-advance');
            } else if (value.type == 2){
              appService<NavigationService>().navigateTo('/my-investments');
            } else {
              appService<NavigationService>().navigateTo('/');
            }
          }
          
        }).catchError((onError) {
          setState(() {
            if (onError is String) {
              this.error = 'Los datos son incorrectos.';
            } else {
              this.error = 'Inténtelo mas tarde.';
            }
          });
        }).whenComplete(() {
          setState(() {
            this.loading = false;
          });
        });
      } catch(e) {
        setState(() {
          this.error = 'Error verifica los datos';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: this.scaffoldKey,
      body: LoginContent(state: this),
    );
  }
}