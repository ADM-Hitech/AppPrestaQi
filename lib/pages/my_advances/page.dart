import 'package:flutter/material.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:prestaqi/models/advance.model.dart';
import 'package:prestaqi/models/details_advance.model.dart';
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/pages/my_advances/content.dart';
import 'package:prestaqi/pages/my_advances/service.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:prestaqi/widgets/drawer_menu.widget.dart';

class MyAdvancePage extends StatefulWidget {
  const MyAdvancePage({ super.key });

  @override
  MyAdvanceState createState() => MyAdvanceState();
}

class MyAdvanceState extends State<MyAdvancePage> {

  PreferenceUser pref = PreferenceUser();
  bool loading = true;
  bool downloading = false;
  double progress = 0;
  MyProfileModel user = MyProfileModel();
  MyAdvancesService serveice = MyAdvancesService();
  List<AdvanceModel> advances = <AdvanceModel>[];
  List<AdvanceModel> advancesActive = <AdvanceModel>[];
  DetailsAdvanceModel forPayment = DetailsAdvanceModel.fromJson({});
  double totalDiscount = 0;
  DateTime date = DateTime.now();
  int nextDayForPay = 15;
  List<String> months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];

  @override
  void initState() {
    super.initState();
    if (date.day > 15) {
      nextDayForPay = DTU.getDaysInMonth(date.year, date.month);
    }

    getUser();
    fetchNextPatment();
  }

  void fetchNextPatment() {
    if (pref.isFixedPayments) {
      if (date.weekday == DateTime.friday) {
        date = date.add(const Duration(days: 7));
      } else if (date.weekday == DateTime.saturday) {
        date = date.add(const Duration(days: 6));
      } else if (date.weekday == DateTime.sunday) {
        date = date.add(const Duration(days: 5));
      } else {
        date = date.add(Duration(days: 5 - date.weekday));
      }

      nextDayForPay = date.day;
    }
  }

  void downloadPDF() async {}

  void fetchAdvances(String periodName) async {
    serveice.getAdvances().then((value) {
      setState(() {
        advancesActive = value.currents;
        advances = value.befores;
        forPayment = value.forPayment;

        if (forPayment.id != 0) {
          totalDiscount = forPayment.totalPayment;
        } else {
          totalDiscount = advancesActive.fold(0, (previousValue, element) => previousValue + (element.paidStatus == 0 ? element.totalWithhold : 0) );
        }

        loading = false;
      });
    }).catchError((onError) {
      setState(() {
        loading = false;
      });
    });
  }

  void getUser() {
    serveice.getMyProfile().then((value) => {
      setState(() {
        user = value;
      }),

      fetchAdvances(user.periodName)
    // ignore: body_might_complete_normally_catch_error
    }).catchError((onError) {
      setState(() {
        loading = false;
      });
    });
  }

  double getFontSize(double width) {
    return width > 414 ? 23 : 16.8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 244, 255, 1),
      extendBodyBehindAppBar: true,
      appBar: appBar(context: context),
      drawer: const DrawerMenu(),
      body: myAdvanceBody(state: this)
    );
  }
}