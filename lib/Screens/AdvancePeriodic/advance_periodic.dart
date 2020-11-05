import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/Advance.dart';
import 'package:prestaQi/Screens/AdvancePeriodic/advance_periodic_content.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:intl/date_symbol_data_local.dart' as local;

class AdvancePeriodic extends StatefulWidget {
  
  final List<Advance> childs;

  AdvancePeriodic({this.childs});

  @override
  AdvancePeriodicState createState() => AdvancePeriodicState();
}

class AdvancePeriodicState extends State<AdvancePeriodic> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  int nextDayForPay = 15;
  DateTime date = DateTime.now();
  DateUtil dateUtil = new DateUtil();
  DateFormat formatDate = new DateFormat('dd/MM/yyyy');
  NumberFormat numberFormat = new NumberFormat("#,###.0#", "en_US");
  List<Advance> childs;
  double totalAdvance = 0;
  double totalRetencion = 0;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    if (this.date.day > 15) {
      this.nextDayForPay = dateUtil.daysInMonth(this.date.month, this.date.year);
    }

    setState(() {
      this.childs = this.widget.childs ?? [];
      this.date = new DateTime(this.date.year, this.date.month, this.nextDayForPay);
    });

    this.processTotals();
  }

  void processTotals() {
    this.childs.forEach((element) {
      setState(() {
        this.totalAdvance += element.amount;
        this.totalRetencion += element.totalWithhold;
      });
    });
  }

  double getFontSize() {
    if (this.screen.width > 414) {
      return 20;
    } else {
      return 17;
    }
  }

  @override
  Widget build(BuildContext context) {
    local.initializeDateFormatting('es');

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
              Navigator.pop(context);
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
          child: Text(
            'A descontar el ${DateFormat.MMMMd('es').format(this.date)}',
            style: TextStyle(
              color: Color.fromRGBO(143, 146, 163, 1),
              fontWeight: FontWeight.w600
            )
          ),
        ),
      ),
      body: AdvancePeriodicContent(state: this),
    );
  }
}