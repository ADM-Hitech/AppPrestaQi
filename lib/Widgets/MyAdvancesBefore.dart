import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as local;

class MyAdvanceBefore extends StatelessWidget {

  final DateTime date;
  final int folio;
  final double total;
  final double sizeText;

  MyAdvanceBefore({
    Key key, 
    @required this.date, 
    @required this.folio, 
    @required this.total,
    this.sizeText = 20
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
              color: Color.fromRGBO(202, 206, 230, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25)
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    DateFormat.MMMMd('es').format(this.date),
                    style: TextStyle(
                      color: Color.fromRGBO(142, 145, 162, 1),
                      fontSize: this.sizeText,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.jm().format(this.date),
                    style: TextStyle(
                      color: Color.fromRGBO(142, 145, 162, 1),
                      fontSize: this.sizeText - 5
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Folio: ${this.folio.toString().padLeft(6, '0')}',
                    style: TextStyle(
                      color: Color.fromRGBO(142, 145, 162, 1),
                      fontSize: this.sizeText,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 100,
            margin: EdgeInsets.only(right: 20, left: 18),
            alignment: Alignment.centerRight,
            child: Text(
              NumberFormat('\$ #,##0.00', 'es_Us').format(this.total),
              style: TextStyle(
                color: Color.fromRGBO(142, 145, 162, 1),
                fontSize: this.sizeText,
                fontWeight: FontWeight.bold
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