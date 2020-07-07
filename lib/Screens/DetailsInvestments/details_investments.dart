import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/DetailsInvestmentModel.dart';
import 'package:prestaQi/Screens/DetailsInvestments/details_investments_content.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

class DetailsInvestments extends StatefulWidget {

  final List<DetailsInvestmentModel> childs;

  DetailsInvestments({this.childs});

  @override
  DetailsInvestmentsState createState() => DetailsInvestmentsState();
}

class DetailsInvestmentsState extends State<DetailsInvestments>{
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  DateFormat formatDate = new DateFormat('dd/MM/yyyy');
  NumberFormat numberFormat = new NumberFormat("#,###.0#", "en_US");

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
  }

  @override
  Widget build(BuildContext context) {
    
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
              Navigator.of(context).pop();
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
          child: Text('Solicitar adelanto', 
            style: TextStyle(
              color: Color.fromRGBO(143, 146, 163, 1),
              fontWeight: FontWeight.w600
            )
          ),
        ),
      ),
      body: DetailsInvestmentsContent(state: this),
    );
  }
}