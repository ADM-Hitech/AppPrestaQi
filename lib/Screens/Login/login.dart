import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/Login/login_content.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

class Login extends StatefulWidget {
  
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
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