import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/MyInvestments/my_investments_content.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';

class MyInvestments extends StatefulWidget {

  @override
  MyInvestmentsState createState() => MyInvestmentsState();
}

class MyInvestmentsState extends State<MyInvestments> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    tabController = TabController(length: 10, vsync: this);
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
          Container(
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
          )
        ],
      ),
      drawer: DrawerMenu(screen: this.screen, hideSlide: this.hideSlide),
      body: MyInvestmentsContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}