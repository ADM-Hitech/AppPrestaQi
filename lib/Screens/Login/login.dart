import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/Login/login_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

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

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
  }
  
  String validateUser(String value) {
    if (value.isEmpty) {
      return 'Ingrese un usuario';
    }

    return null;
  }

  void submit() async {

    if (this.formKey.currentState.validate()) {
      try {
        setState(() {
          this.loading = true;
        });

        appService<AuthService>().auth(this.emailController.text.replaceAll(new RegExp(r"\s+"), ''), this.passwordController.text).then((value) {
          if (value.firstLogin) {
            //appService<NavigationService>().showContract(context, value.contract);
            appService<NavigationService>().navigateTo('/change-password');
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