import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/TechnicalSupport/technical_support_content.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';

class TechnicalSupport extends StatefulWidget {

  @override
  TechnicalSupportState createState() => TechnicalSupportState();
}

class TechnicalSupportState extends State<TechnicalSupport> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
  }

  void showSlide() {
    scaffoldKey.currentState.openDrawer();
  }

  void hideSlide() {
    scaffoldKey.currentState.openEndDrawer();
  }

  double getFontSize() {
    if (this.screen.width > 375) {
      return 18;
    } else {
      return 15;
    }
  }

  double getFontSizeData() {
    if (this.screen.width > 375) {
      return 19;
    } else {
      return 17;
    }
  }

  double getSizeCircleIcon() {
    if (this.screen.width > 375) {
      return 65;
    } else {
      return 50;
    }
  }

  double getSizeIcon() {
    if (this.screen.width > 375) {
      return 35;
    } else {
      return 25;
    }
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
          GestureDetector(
            onTap: () {
              appService<NavigationService>().navigateTo('/notification');
            },
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.only(right: 20),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      'assets/icons/ico-notificaciones-nuevo.svg',
                      color: Colors.white,
                      width: 25,
                    ),
                  ),
                  Positioned(
                    top: 17,
                    right: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(4.5)
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      drawer: DrawerMenu(screen: this.screen, hideSlide: this.hideSlide),
      body: TechnicalSupportContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}