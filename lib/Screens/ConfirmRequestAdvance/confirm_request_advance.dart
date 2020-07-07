import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/CalculateAdvance.dart';
import 'package:prestaQi/Models/InfoBank.dart';
import 'package:prestaQi/Screens/ConfirmRequestAdvance/confirm_request_advance_content.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/RequestAdvance.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:date_util/date_util.dart';
import 'package:prestaQi/Services/UserService.dart';

import '../../Utils/ScreenResponsive.dart';

class ConfirmRequestAdvance extends StatefulWidget {
  
  final CalculateAdvance calculateAdvance;

  ConfirmRequestAdvance({this.calculateAdvance});

  @override
  ConfirmRequestAdvanceState createState() => ConfirmRequestAdvanceState();
}

class ConfirmRequestAdvanceState extends State<ConfirmRequestAdvance> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  double totalDiscount = 0;
  double porcen = 1;
  DateTime dateNextPay = DateTime.now();
  DateUtil dateUtil = new DateUtil();
  DateFormat formatDate = new DateFormat('dd/MM/yyyy');
  InfoBank infoBank = new InfoBank(accountNumber: '0000', institutionName: '', clabe: '');
  bool loading = true;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.fetchInfoRequest();
    this.fetchInfoBank();
    setState(() {
      this.porcen = (this.widget.calculateAdvance.amount * 100 ) / this.widget.calculateAdvance.maximumAmount;
      this.porcen = this.porcen / 100;
    });
  }

  void fetchInfoRequest() {
    setState(() {
      this.loading = true;
    });

    appService<RequestAdvanceService>().calculateAdvanceWithAmount(this.widget.calculateAdvance.amount).then((value) {
      setState(() {
        this.totalDiscount = value.totalWithhold;
        if (this.dateNextPay.day >= 15) {
          var day = dateUtil.daysInMonth(this.dateNextPay.month, this.dateNextPay.year);
          this.dateNextPay = new DateTime(this.dateNextPay.year, this.dateNextPay.month, day);
        } else {
          this.dateNextPay = new DateTime(this.dateNextPay.year, this.dateNextPay.month, 15);
        }
      });
    }).catchError((onError) {
      print(onError);
    }).whenComplete(() {
      setState(() {
        this.loading = false;
      });
    });
  }

  void fetchInfoBank() {
    setState(() {
      this.loading = true;
    });

    appService<UserService>().getInfoBanck().then((value) {
      setState(() {
        this.infoBank = value;
      });
    }).catchError((onError) {
      print(onError);
    }).whenComplete(() {
      setState(() {
        this.loading = false;
      });
    });
  }

  void acepted() async {
    setState(() {
      this.loading = true;
    });

    this.infoBank.amount = this.widget.calculateAdvance.amount;
    var result = await appService<NavigationService>().showCartaMandato(context, this.infoBank);
    if (result as bool) {

      appService<RequestAdvanceService>().requestAdvance(this.infoBank.amount).then((value) async {
        if (value) {
          await appService<NavigationService>().showAlertSuccess(context);
          appService<NavigationService>().navigateTo('/request-advance');
        } else {
          appService<NavigationService>().showErrorRequestAdvance(context);
        }

        setState(() {
          this.loading = false;
        });
      }).catchError((onError) {
        setState(() {
          this.loading = true;
        });
      });
    }
  }

  String getLast4Char() {
    int length = this.infoBank.accountNumber.length;
    return this.infoBank.accountNumber.substring(length - 4);
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
              appService<NavigationService>().navigateTo('/request-advance');
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
          child: Text('Solicitar adelanto', 
            style: TextStyle(
              color: Color.fromRGBO(143, 146, 163, 1),
              fontWeight: FontWeight.w600
            )
          ),
        ),
      ),
      body: ConfirmRequestAdvanceContent(state: this),
    );
  }
}