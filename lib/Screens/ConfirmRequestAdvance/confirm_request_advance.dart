import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/CalculateAdvance.dart';
import 'package:prestaQi/Models/DetailsAdvance.dart';
import 'package:prestaQi/Models/InfoBank.dart';
import 'package:prestaQi/Models/MyProfile.dart';
import 'package:prestaQi/Models/PreAdvance.dart';
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
  PreAdvance calculateAdvance;
  MyProfileModel user = new MyProfileModel();
  int nextDayForPay = 15;
  DateTime date = DateTime.now();
  List<DetailsAdvance> detailsDates = new List<DetailsAdvance>();

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    if (this.date.day > 15) {
      this.nextDayForPay = dateUtil.daysInMonth(this.date.month, this.date.year);
    }
    this.getUser();
    setState(() {
      this.porcen = (this.widget.calculateAdvance.amount * 100 ) / this.widget.calculateAdvance.maximumAmount;
      this.porcen = this.porcen / 100;
    });
  }

  void fetchInfoRequest(int userId, String periodName) {
    setState(() {
      this.loading = true;
    });

    appService<RequestAdvanceService>().calculateAdvanceWithAmount(this.widget.calculateAdvance.amount).then((value) {
      setState(() {
        this.calculateAdvance = value;
        this.calculateAdvance.user = this.user;
        this.totalDiscount = value.advance.totalWithhold;
        this.dateNextPay = value.advance.limitDate;

        var total = calculateAdvance.advance.totalWithhold;

        if (this.calculateAdvance.details.length > 0) {
          for (var i = 0; i <= this.calculateAdvance.details.length - 1; i++) {
            if (total > 0) {
              if (total <= this.calculateAdvance.details[i].totalPayment) {
                this.detailsDates.add(new DetailsAdvance(datePayment: this.calculateAdvance.details[i].datePayment, totalPayment: total));
                total = 0;
              } else {
                this.detailsDates.add(new DetailsAdvance(datePayment: this.calculateAdvance.details[i].datePayment, totalPayment: this.calculateAdvance.details[i].totalPayment));
                total -= this.calculateAdvance.details[i].totalPayment;
              }
            }
          }
        }

        this.fetchInfoBank();

        this.loading = false;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void getUser() {
    appService<UserService>().getMyProfile().then((value) {
      setState(() {
        this.user = value;
      });

      this.fetchInfoRequest(this.user.id, this.user.periodName);
    }).catchError((onError) {
      print(onError);
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

    this.infoBank.amount = this.widget.calculateAdvance.amount;
    var url = this.widget.calculateAdvance.urlCartaMandato+'&amount=${this.calculateAdvance.advance.amount}&days=${this.calculateAdvance.advance.dayForPayment}&commision=${this.calculateAdvance.advance.comission}&totalAmount=${this.calculateAdvance.advance.totalWithhold}';

    String dates = "";
    if (detailsDates.length > 0) {
      for (num i = 0; i < detailsDates.length; i++) {
        dates += formatDate.format(detailsDates[i].datePayment);
        if (i != (detailsDates.length - 1)) {
          dates += ",";
        }
      }
    } else {
      dates = formatDate.format(dateNextPay);
    }

    url += "&dates=$dates";

    var result = await appService<NavigationService>().showIframeCartaMandato(context, url, this.calculateAdvance.advance) ?? false;
    if (result as bool) {

      setState(() {
        this.loading = true;
      });

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
    if (length > 4) {
      return this.infoBank.accountNumber.substring(length - 4);  
    }
    return this.infoBank.accountNumber;
  }

  String getAmount() {
    return NumberFormat.currency(symbol: '').format(this.widget.calculateAdvance.amount);
  }

  String getAmountDiscount() {
    return NumberFormat.currency(symbol: '').format(this.totalDiscount);
  }

  String formatCurrency(double amount) {
    return NumberFormat.currency(symbol: '').format(amount);
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