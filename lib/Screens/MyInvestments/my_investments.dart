import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/InvestmentModel.dart';
import 'package:prestaQi/Screens/MyInvestments/my_investments_content.dart';
import 'package:prestaQi/Services/InvestmentsService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Widgets/ActionMenuAlert.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';

class MyInvestments extends StatefulWidget {

  @override
  MyInvestmentsState createState() => MyInvestmentsState();
}

class MyInvestmentsState extends State<MyInvestments> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  TabController tabController;
  List<InvestmentModel> investments = new List<InvestmentModel>();
  bool loading = true;
  DateFormat formatDate = new DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.fetchInversion();
  }

  void fetchInversion() {
    appService<InvestmentsService>().fetchInvestment().then((value) {
      setState(() {
        this.investments = value;
        this.tabController = TabController(length: this.investments.length, vsync: this);

        this.loading = false;
      });
    }).catchError((onError) {
      setState(() {
        this.loading = false;
      });
    });
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
      body: MyInvestmentsContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}