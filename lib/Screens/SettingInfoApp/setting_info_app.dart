import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Screens/SettingInfoApp/setting_info_app_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

class SettingInfoApp extends StatefulWidget {

  @override
  SettingInfoAppState createState() => SettingInfoAppState();
}

class SettingInfoAppState extends State<SettingInfoApp> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  UserToken user;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.me();
  }

  void me() {
     appService<AuthService>().me().then((value) {
       setState(() {
         this.user = value;
       });
     }).catchError((onError) {});
  }

  void showTerminos() {
    appService<NavigationService>().showIframe(context, this.user.urlTerminosCondiciones, null, null);
  }

  void showAvisoPrivacidad() {
    appService<NavigationService>().showIframe(context, this.user.urlAvisoPrivacidad, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 244, 255, 1),
      key: this.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 244, 255, 1),
        elevation: 0.0,
        centerTitle: true,
        leading: Align(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                'assets/icons/ico-flecha-izquierda.svg',
                color: Color.fromRGBO(143, 146, 163, 1),
                width: 20,
              ),
            ),
          ),
        ),
        title: Container(
          child: Text(
            'Información de la app',
            style: TextStyle(
              color: Color.fromRGBO(143, 146, 163, 1),
              fontWeight: FontWeight.w600
            )
          ),
        ),
      ),
      body: SettingInfoAppContent(state: this),
    );
  }
}