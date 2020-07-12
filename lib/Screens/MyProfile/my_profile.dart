import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/MyProfile.dart';
import 'package:prestaQi/Screens/MyProfile/my_profile_content.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Services/UserService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Widgets/ActionMenuAlert.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';

class MyProfile extends StatefulWidget {

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  MyProfileModel user = new MyProfileModel(firstName: '-', lastName: '- -', id: 0);
  bool loading = true;
  NumberFormat numberFormat = new NumberFormat("#,###.0#", "en_US");

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.fetchMyProfile();
  }

  void fetchMyProfile() {
    appService<UserService>().getMyProfile().then((value) {
      setState(() {
        this.user = value;
      });

      setState(() {
        this.loading = false;
      });
    }).catchError((onError) {
      setState(() {
        this.loading = false;
      });
    });
  }

  String letterName() {
    var fullName = this.user.firstName + ' ' + this.user.lastName;
    var split = fullName.split(' ');
    String letters = (split[0][0] ?? '') + (split[1][0] ?? '');

    return letters;
  }

  void showSlide() {
    scaffoldKey.currentState.openDrawer();
  }

  void hideSlide() {
    scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 244, 255, 1),
      key: this.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: Align(
          child: GestureDetector(
            onTap: () {
              this.showSlide();
            },
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                'assets/icons/ico-menu.svg',
                color: Colors.white,
                width: 30,
              ),
            ),
          ),
        ),
        title: Container(
          child: SvgPicture.asset(
            'assets/icons/ico-logo.svg',
            color: Colors.white,
            width: 110,
          ),
        ),
        actions: [
          ActionMenuAlert()
        ],
      ),
      drawer: DrawerMenu(screen: this.screen, hideSlide: this.hideSlide),
      body: MyProfileContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}