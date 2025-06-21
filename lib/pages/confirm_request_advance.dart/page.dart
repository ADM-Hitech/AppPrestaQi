import 'package:flutter/material.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:intl/intl.dart';
import 'package:prestaqi/models/calculate_advance.model.dart';
import 'package:prestaqi/models/details_advance.model.dart';
import 'package:prestaqi/models/info_bank.model.dart';
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/models/pre_advance.model.dart';
import 'package:prestaqi/pages/confirm_request_advance.dart/content.dart';
import 'package:prestaqi/pages/confirm_request_advance.dart/service.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';

class ConfirmRequestAdvancePage extends StatefulWidget {
  final CalculateAdvance calculateAdvance;
  
  const ConfirmRequestAdvancePage({ super.key, required this.calculateAdvance });

  @override
  ConfirmRequestAdvanceState createState() => ConfirmRequestAdvanceState();
}

class ConfirmRequestAdvanceState extends State<ConfirmRequestAdvancePage> {
  ConfirmRequestAdvanceService service = ConfirmRequestAdvanceService();
  double totalDiscount = 0;
  double porcen = 1;
  DateTime dateNextPay = DateTime.now();
  DateFormat formatDate = DateFormat('dd/MM/yyyy');
  InfoBankModel infoBank = InfoBankModel(accountNumber: '0000', institutionName: '', clabe: '');
  bool loading = true;
  late PreAdvanceModel calculateAdvance;
  MyProfileModel user = MyProfileModel();
  int nextDayForPay = 15;
  DateTime date = DateTime.now();
  List<DetailsAdvanceModel> detailsDates = [];
  PreferenceUser pref = PreferenceUser();

  @override
  void initState() {
    super.initState();

    if (date.day > 15) {
      nextDayForPay = DTU.getDaysInMonth(date.year, date.month);
    }

    setState(() {
      porcen = (widget.calculateAdvance.amount * 100 ) / widget.calculateAdvance.maximumAmount;
      porcen = porcen / 100;
    });

    getUser();
  }

  void fetchInfoRequest(int userId, String periodName) {
    setState(() {
      loading = true;
    });

    service.calculateAdvanceWithAmount(widget.calculateAdvance.amount).then((value) {
      setState(() {
        calculateAdvance = value;
        calculateAdvance.user = user;
        totalDiscount = value.advance.totalWithhold;
        dateNextPay = value.advance.limitDate;

        var total = calculateAdvance.advance.totalWithhold;

        if (calculateAdvance.details.isNotEmpty) {
          for (var i = 0; i <= calculateAdvance.details.length - 1; i++) {
            if (total > 0) {
              if (total <= calculateAdvance.details[i].totalPayment) {
                detailsDates.add(DetailsAdvanceModel(datePayment: calculateAdvance.details[i].datePayment, totalPayment: total));
                total = 0;
              } else {
                detailsDates.add(DetailsAdvanceModel(datePayment: calculateAdvance.details[i].datePayment, totalPayment: calculateAdvance.details[i].totalPayment));
                total -= calculateAdvance.details[i].totalPayment;
              }
            }
          }
        }

        fetchInfoBank();

        loading = false;
      });
    }).catchError((onError) {
      setState(() {
        loading = false;
      });
    });
  }

  void getUser() {
    appService<AppService>().getMyProfile().then((value) {
      setState(() {
        user = value;
      });

      fetchInfoRequest(user.id, user.periodName);
    }).catchError((onError) {});
  }

  void fetchInfoBank() {
    setState(() {
      loading = true;
    });

    service.getInfoBanck().then((value) {
      setState(() {
        infoBank = value;
      });
    }).catchError((onError) {}).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  void acepted() async {

    infoBank.amount = widget.calculateAdvance.amount;
    var url = '${widget.calculateAdvance.urlCartaMandato}&amount=${calculateAdvance.advance.amount}&days=${calculateAdvance.advance.dayForPayment}&commision=${calculateAdvance.advance.comission.toInt()}&totalAmount=${calculateAdvance.advance.totalWithhold}';

    String dates = "";
    if (detailsDates.isNotEmpty) {
      for (int i = 0; i < detailsDates.length; i++) {
        dates += formatDate.format(detailsDates[i].datePayment);
        if (i != (detailsDates.length - 1)) {
          dates += ",";
        }
      }
    } else {
      dates = formatDate.format(dateNextPay);
    }

    url += "&dates=$dates";

    var result = await appService<NavigationService>().showIframeCartaMandato(context, url, calculateAdvance.advance) ?? false;
    if (result as bool) {

      setState(() {
        loading = true;
      });

      service.requestAdvance(infoBank.amount, widget.calculateAdvance.latitude, widget.calculateAdvance.longitude).then((value) async {
        if (value) {
          await appService<NavigationService>().showAlertSuccess(context);
          appService<NavigationService>().navigateTo('request-advance');
        } else {
          appService<NavigationService>().showErrorRequestAdvance(context);
        }

        setState(() {
          loading = false;
        });
      }).catchError((onError) {
        setState(() {
          loading = true;
        });
      });
    }
  }

  String getLast4Char() {
    int length = infoBank.accountNumber.length;
    if (length > 4) {
      return infoBank.accountNumber.substring(length - 4);  
    }
    return infoBank.accountNumber;
  }

  String getAmount() {
    return NumberFormat.currency(symbol: '').format(widget.calculateAdvance.amount);
  }

  String getAmountDiscount() {
    return NumberFormat.currency(symbol: '').format(totalDiscount);
  }

  String formatCurrency(double amount) {
    return NumberFormat.currency(symbol: '').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 244, 255, 1),
      appBar: appBar(context: context, title: 'Solicitar adelanto', bgColor: const Color.fromRGBO(239, 244, 255, 1), textColor: const Color.fromRGBO(143, 146, 163, 1)),
      body: confirmRequestAdvanceBody(state: this),
    );
  }
}