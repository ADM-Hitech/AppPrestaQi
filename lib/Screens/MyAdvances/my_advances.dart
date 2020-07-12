import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Models/MyAdvanceModel.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Screens/MyAdvances/my_advances_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/RequestAdvance.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Widgets/ActionMenuAlert.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';
import 'package:prestaQi/Services/NavigationService.dart';


class MyAdvances extends StatefulWidget {

  @override
  MyAdvancesState createState() => MyAdvancesState();
}

class MyAdvancesState extends State<MyAdvances> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  UserToken user = new UserToken();
  List<MyAdvanceModel> myAdvances = new List<MyAdvanceModel>();
  List<MyAdvanceModel> myAdvancesActive = new List<MyAdvanceModel>();
  double totalDiscount = 0;
  DateTime date = DateTime.now();
  int nextDayForPay = 15;
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
    this.getUser();
  }

  void fetchMyAdvances(int userId) async {
    appService<RequestAdvanceService>().getMyAdvances(userId).then((value) {
      setState(() {
        value.forEach((element) {

          this.myAdvances.add(element); //detele after test

          if (element.dateAdvance.month == this.date.month) {
            if (this.nextDayForPay == 15 && (element.dateAdvance.day >= 1 && element.dateAdvance.day <= 15)) {
              
              this.myAdvancesActive.add(element);
              this.totalDiscount += element.totalWithhold;

            } else if (this.nextDayForPay != 15 && (element.dateAdvance.day >= 16 && element.dateAdvance.day <= this.nextDayForPay)) { 
              
              this.myAdvancesActive.add(element);
              this.totalDiscount += element.totalWithhold;

            } else {
              
              this.myAdvances.add(element);

            }
          } else {
            this.myAdvances.add(element);
          }
        });

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
    appService<AuthService>().me().then((value) {
      setState(() {
        this.user = value;
      });

      this.fetchMyAdvances(this.user.userId);
    }).catchError((onError) {
      print(onError);
    });
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