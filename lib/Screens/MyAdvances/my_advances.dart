import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Models/Advance.dart';
import 'package:prestaQi/Models/DetailsAdvance.dart';
import 'package:prestaQi/Models/MyProfile.dart';
import 'package:prestaQi/Screens/MyAdvances/my_advances_content.dart';
import 'package:prestaQi/Services/RequestAdvance.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Services/UserService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Widgets/ActionMenuAlert.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';


class MyAdvances extends StatefulWidget {

  @override
  MyAdvancesState createState() => MyAdvancesState();
}

class MyAdvancesState extends State<MyAdvances> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  MyProfileModel user = new MyProfileModel();
  List<Advance> myAdvances = new List<Advance>();
  List<Advance> myAdvancesActive = new List<Advance>();
  DetailsAdvance forPayment;
  double totalDiscount = 0;
  DateTime date = DateTime.now();
  int nextDayForPay = 15;
  DateTime nextDateForPay;
  DateUtil dateUtil = new DateUtil();
  bool loading = true;
  List<String> months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    if (this.date.day > 15) {
      this.nextDayForPay = dateUtil.daysInMonth(this.date.month, this.date.year);
    }
    //this.fetchDatesPeriod();
    this.getUser();
  }

  void fetchMyAdvances(int userId, String periodName) async {
    appService<RequestAdvanceService>().getMyAdvances(userId).then((details) {
      setState(() {
        this.myAdvancesActive = details.currents;
        this.myAdvances = details.befores;
        this.forPayment = details.forPayment;
        if (this.forPayment.id != null) {
          this.totalDiscount = this.forPayment.totalPayment;
        } else {
          this.totalDiscount = this.myAdvancesActive.fold(0, (double value, element) => value + (element.paidStatus == 0 ? element.totalWithhold : 0));
        }

        this.loading = false;
      });

    }).catchError((onError) {
      print(onError);
      setState(() {
        this.loading = false;
      });
    });
  }

  void getUser() {
    appService<UserService>().getMyProfile().then((value) {
      setState(() {
        this.user = value;
      });

      this.fetchMyAdvances(this.user.id, this.user.periodName);
    }).catchError((onError) {
      print(onError);
    });
  }

  void fetchDatesPeriod() {
    appService<RequestAdvanceService>().getDatesPeriod().then((value) {
      this.nextDateForPay = value.finish;
    }).catchError((onError) {});
  }

  double getFontSize() {
    if (this.screen.width > 414) {
      return 23;
    } else {
      return 16.8;
    }
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
      body: MyAdvancesContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}