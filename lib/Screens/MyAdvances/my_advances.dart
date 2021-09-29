import 'dart:io';

import 'package:date_util/date_util.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestaQi/Models/Advance.dart';
import 'package:prestaQi/Models/DetailsAdvance.dart';
import 'package:prestaQi/Models/MyProfile.dart';
import 'package:prestaQi/Screens/MyAdvances/my_advances_content.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/RequestAdvance.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Services/UserService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Widgets/ActionMenuAlert.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';


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
  PDFDocument doc;
  double progress = 0;
  bool downloading = false;

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
    this.doc = await PDFDocument.fromURL("https://prestaqi.com/estadodecuenta/$userId.pdf").catchError((onError) => {
      appService<NavigationService>().showErrorRequestAdvance(context)
    });
    setState(() {
      this.loading = false;
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

  void downloadPDF() async {
    Dio dio = new Dio();
    var dirDown;

    try {
      if (Platform.isIOS) {
        dirDown = await getApplicationDocumentsDirectory();
      } else {
        dirDown = await DownloadsPathProvider.downloadsDirectory;
      }

      var permissionStatus = await Permission.storage.request().isGranted;
      if (permissionStatus) {

        setState(() {
          this.downloading = true;
        });

        await dio.download(
          "https://prestaqi.com/estadodecuenta/${this.user.id}.pdf",
          "${dirDown.path}/estadodecuenta.pdf",
          onReceiveProgress: (rec, total) {
            setState(() {
              this.progress = double.parse(((rec / total) * 100).floor().toString());
            });
          }
        );

        var byteDataFile = new File("${dirDown.path}/estadodecuenta.pdf").readAsBytesSync();
        await Share.file('estado de cuenta', 'estadodecuenta.pdf', byteDataFile, 'application/pdf');

        setState(() {
          this.downloading = false;
          this.progress = 0;
        });
      }
    } catch (e) {
      appService<NavigationService>().showErrorRequestAdvance(context);
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
          ActionMenuAlert()
        ],
      ),
      drawer: DrawerMenu(screen: this.screen, hideSlide: this.hideSlide),
      body: MyAdvancesContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}