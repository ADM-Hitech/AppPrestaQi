import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Screens/SettingDeleteAccount/setting_delete_account_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Services/UserService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

class SettingDeleteAccount extends StatefulWidget {
  
  @override
  SettingDeleteAccountState createState() => SettingDeleteAccountState();
}

class SettingDeleteAccountState extends State<SettingDeleteAccount> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  UserToken user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.getUser();
  }

  void getUser() {
    appService<AuthService>().me().then((value) {
      setState(() {
        this.user = value;
        this.loading = false;
      });
    }).catchError((onError) {
      print(onError);
      setState(() {
        this.loading = false;
      });
    });
  }

  void deleteMyAccount() async {
    bool accept = await appService<NavigationService>().showConfirmDeleteAccount(context) as bool;
    if (accept) {
      setState(() {
        this.loading = true;
      });
      
      appService<UserService>().deleteMyAccount(this.user.userId, this.user.type).then((value) => {
        if (value) {
          appService<AuthService>().logout().then((value) {
            appService<NavigationService>().navigateTo('/index-auth');
          }).catchError((onError) {
            print(onError);
          })
        }
      }).catchError((onError) {});
    }
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
            'Eliminar cuenta',
            style: TextStyle(
              color: Color.fromRGBO(143, 146, 163, 1),
              fontWeight: FontWeight.w600
            )
          ),
        ),
      ),
      body: SettingDeleteAccountContent(state: this),
    );
  }
}