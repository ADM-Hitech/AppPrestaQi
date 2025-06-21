import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart' as local;
import 'package:intl/intl.dart';

class AdvancesAfter extends StatelessWidget {
  
  final DateTime date;
  final double total;
  final double sizeText;

  const AdvancesAfter({
    Key? key,
    required this.date,
    required this.total,
    this.sizeText = 23,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    local.initializeDateFormatting('es');
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 25),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(203, 208, 232, .5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 0)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(51, 51, 255, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25)
              )
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Saldo Total',
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 102, 1),
                  fontSize: sizeText - 3,
                ),
              ),
              Text(
                'a descontar\r\nel ${DateFormat.MMMMd('es').format(date)}',
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 102, 1),
                  fontSize: sizeText,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Container(
            width: 95,
            margin: const EdgeInsets.only(right: 25, left: 25),
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                NumberFormat('\$ #,##0.00', 'es_Us').format(total),
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 102, 1),
                  fontSize: sizeText,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 25),
            child: SvgPicture.asset(
              'assets/icons/ico-flecha-derecha.svg',
              color: const Color.fromRGBO(142, 145, 162, 1),
              width: 15,
            ),
          )
        ],
      ),
    );
  }
}