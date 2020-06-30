import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/ChangePassword/change_password_content.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class ChangePassword extends StatefulWidget {

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {

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
      backgroundColor: HexColor.fromHex('#000066'),
      key: this.scaffoldKey,
      body: ChangePasswordContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}