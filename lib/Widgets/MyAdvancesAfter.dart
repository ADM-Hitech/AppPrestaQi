import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as local;

class MyAdvanceAfter extends StatelessWidget {

  final DateTime date;
  final double total;
  final double sizeText;

  MyAdvanceAfter({
    Key key, 
    @required this.date, 
    @required this.total,
    this.sizeText = 23
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    local.initializeDateFormatting('es');

    return Container(
      height: 90,
      margin: EdgeInsets.only(bottom: 25),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
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
            decoration: BoxDecoration(
              color: Color.fromRGBO(51, 51, 255, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25)
              )
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Saldo Total',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 102, 1),
                          fontSize: this.sizeText - 3,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'a descontar\r\nel ${DateFormat.MMMMd('es').format(this.date)}',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 102, 1),
                          fontSize: this.sizeText,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            margin: EdgeInsets.only(right: 25, left: 25),
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                NumberFormat('\$ #,##0.00', 'es_Us').format(this.total),
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 102, 1),
                  fontSize: this.sizeText,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 25),
            child: SvgPicture.asset(
              'assets/icons/ico-flecha-derecha.svg',
              color: Color.fromRGBO(142, 145, 162, 1),
              width: 15,
            ),
          )
        ],
      ),
    );
  }
}