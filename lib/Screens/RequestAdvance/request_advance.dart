import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/CalculateAdvance.dart';
import 'package:prestaQi/Screens/RequestAdvance/request_advance_content.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/RequestAdvance.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Services/UserService.dart';
import 'package:prestaQi/Utils/HexColor.dart';
import 'package:prestaQi/Widgets/ActionMenuAlert.dart';
import 'package:prestaQi/Widgets/DrawerMenu.dart';

import '../../Utils/ScreenResponsive.dart';

class RequestAdvance extends StatefulWidget {

  @override
  RequestAdvanceState createState() => RequestAdvanceState();
}

class RequestAdvanceState extends State<RequestAdvance> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;

  double valueAdvance = 0;
  double maxValue = 1;
  Color colorAmount = HexColor.fromHex('#ff2626');
  bool loading = true;
  bool errorAmount = true;
  bool isBlocked = false;
  CalculateAdvance calculateAdvance = new CalculateAdvance();
  final TextEditingController valueControl = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.fetchMaxMount();
    this.valueControl.text = this.valueAdvance.toStringAsFixed(2);
  }

  void updateValueAdvance(double value) {
    setState(() {
      this.valueAdvance = value.floorToDouble();
      if (this.valueAdvance > 0 ) {
        this.colorAmount = Color.fromRGBO(77, 77, 77, 1);
        this.errorAmount = false;
      } else {
        this.colorAmount = HexColor.fromHex('#ff2626');
        this.errorAmount = true;
      }

      this.valueControl.text = NumberFormat.currency(symbol: '').format(this.valueAdvance);
    });
  }

  void fetchMaxMount() {
    appService<UserService>().getMyProfile().then((user) {
      setState(() {
        this.isBlocked = user.isBlocked;
        this.calculateAdvance.urlCartaMandato = user.urlCartaMandato;
      });
      
      appService<RequestAdvanceService>().calculateAdvance().then((value) {
        setState(() {
          this.maxValue = value <= 0 ? 1 : value;
          this.loading = false;
        });

      }).catchError((onError) {
        print(onError);
        this.loading = false;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void requestAdvance() {
    setState(() {
      this.colorAmount = Color.fromRGBO(77, 77, 77, 1);
    });

    if (this.errorAmount) {
      setState(() {
        this.colorAmount = HexColor.fromHex('#ff2626');
      });
    } else {

      this.calculateAdvance.amount = this.valueAdvance;
      this.calculateAdvance.maximumAmount = this.maxValue;

      appService<NavigationService>().navigateTo('/confirm-request-advance', arguments: calculateAdvance);
    }
  }

  double getSizeTitle() {
    if (this.screen.height > 667) {
      return 50;
    } else {
      return 40;
    }
  }

  double getHightTitle() {
    if (this.screen.height > 667) {
      return 320;
    } else {
      return 280;
    }
  }

  double getTopBody() {
    if (this.screen.height > 667) {
      return 250;
    } else {
      return 200;
    }
  }

  double getSpacesBetween() {
    if (this.screen.height > 667) {
      return 15;
    } else {
      return 20;
    }
  }

  double getSpacesBetweenButton() {
    if (this.screen.height > 667) {
      return 80;
    } else {
      return 30;
    }
  }

  double getSpacesBetweenSlide() {
    if (this.screen.height > 667) {
      return 70;
    } else {
      return 25;
    }
  }

  void updateValueWithInput(String value) {
    value = value.replaceAll(',', '');
    var newValue = double.tryParse(value);

    if (newValue != null) {
      setState(() {
        if (newValue <= 0 || newValue > this.maxValue) {
          this.colorAmount = HexColor.fromHex('#ff2626');
          this.errorAmount = true;
        } else {
          this.colorAmount = Color.fromRGBO(77, 77, 77, 1);
          this.errorAmount = false;
        }
      });
    }

    if (newValue != null && newValue <= this.maxValue ) {
      setState(() {
        this.valueAdvance = newValue;
        //this.valueControl.text = '\$${this.valueAdvance.toStringAsFixed(2)}';
      });
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
      backgroundColor: Colors.white,
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
      body: RequestAdvanceContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}