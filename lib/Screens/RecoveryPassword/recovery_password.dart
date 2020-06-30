import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/RecoveryPassword/recovery_password_content.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

class RecoveryPassword extends StatefulWidget {

  @override
  RecoveryPasswordState createState() => RecoveryPasswordState();
}

class RecoveryPasswordState extends State<RecoveryPassword> {

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
      body: RecoveryPasswordContent(state: this),
    );
  }
}