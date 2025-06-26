import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart' as local;
import 'package:intl/intl.dart';

class AdvancesBefore extends StatelessWidget {
  final DateTime date;
  final int folio;
  final double total;
  final double sizeText;

  const AdvancesBefore({
    super.key, 
    required this.date, 
    required this.folio, 
    required this.total,
    this.sizeText = 20
  });

  @override
  Widget build(BuildContext context) {
    local.initializeDateFormatting('es');
    double width = MediaQuery.of(context).size.width;
    DateTime currentDate = DateTime.now();

    return Container(
      height: 90,
      width: width,
      margin: const EdgeInsets.only(bottom: 25),
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
              color: Color.fromRGBO(202, 206, 230, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25)
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.year < currentDate.year ? DateFormat.yMMMd('es').format(date) : DateFormat.MMMMd('es').format(date),
                  style: TextStyle(
                    color: const Color.fromRGBO(142, 145, 162, 1),
                    fontSize: sizeText - 2,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  DateFormat.jm().format(date),
                  style: TextStyle(
                    color: const Color.fromRGBO(142, 145, 162, 1),
                    fontSize: sizeText - 5
                  ),
                ),
                Text(
                  'Folio: ${folio.toString().padLeft(6, '0')}',
                  style: TextStyle(
                    color: const Color.fromRGBO(142, 145, 162, 1),
                    fontSize: sizeText - 2,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 100,
            margin: const EdgeInsets.only(right: 20, left: 18),
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                NumberFormat('\$ #,##0.00', 'es_Us').format(total),
                style: TextStyle(
                  color: const Color.fromRGBO(142, 145, 162, 1),
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
              colorFilter: ColorFilter.mode(const Color.fromRGBO(142, 145, 162, 1), BlendMode.srcIn),
              width: 15,
            ),
          )
        ],
      ),
    );
  }

}