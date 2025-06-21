import 'package:flutter/material.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:intl/intl.dart';
import 'package:prestaqi/models/advance.model.dart';
import 'package:prestaqi/pages/advance_periodic/content.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:intl/date_symbol_data_local.dart' as local;

class AdvancePeriodicPage extends StatefulWidget {
  final List<AdvanceModel> childs;

  const AdvancePeriodicPage({super.key,  required this.childs });

  @override
  AdvancePeriodicState createState() => AdvancePeriodicState();
}

class AdvancePeriodicState extends State<AdvancePeriodicPage> {

  int nextDayForPay = 15;
  DateTime date = DateTime.now();
  DateFormat formatDate = DateFormat('dd/MM/yyyy');
  NumberFormat numberFormat = NumberFormat("#,###.0#", "en_US");
  List<AdvanceModel> childs = [];
  double totalAdvance = 0;
  double totalRetencion = 0;

  @override
  void initState() {
    super.initState();

    if (date.day > 15) {
      nextDayForPay = DTU.getDaysInMonth(date.year, date.month);
    }

    setState(() {
      childs = widget.childs;
      date = DateTime(date.year, date.month, nextDayForPay);
    });

    processTotals();
  }

  void processTotals() {
    for (var element in childs) {
      setState(() {
        totalAdvance += element.amount;
        totalRetencion += element.totalWithhold;
      });
    }
  }

  double getFontSize(double width) {
    if (width > 414) {
      return 20;
    } else {
      return 17;
    }
  }

  @override
  Widget build(BuildContext context) {
    local.initializeDateFormatting('es');

    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 244, 255, 1),
      appBar: appBar(context: context, title: 'A descontar el ${DateFormat.MMMMd('es').format(date)}', bgColor: const Color.fromRGBO(239, 244, 255, 1), textColor: const Color.fromRGBO(143, 146, 163, 1)),
      body: advancePeriodicBody(state: this),
    );
  }
}