import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/MyAdvances/my_advances.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/HexColor.dart';
import 'package:prestaQi/Widgets/MyAdvancesAfter.dart';
import 'package:prestaQi/Widgets/MyAdvancesBefore.dart';

class MyAdvancesContent extends StatelessWidget {

  final MyAdvancesState state;

  MyAdvancesContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 290,
              width: this.state.screen.width,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1292ff'),
                image: DecorationImage(
                  image: AssetImage('assets/images/background_header.png'),
                  fit: BoxFit.none,
                  alignment: Alignment.bottomCenter
                )
              ),
            ),
          ),
          Positioned(
            top: 95.0,
            child: Container(
              width: this.state.screen.width,
              height: this.state.screen.height,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: HexColor.fromHex('#eff4ff'),
                borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 102, .4),
                    spreadRadius: 5,
                    blurRadius: 50,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 0),
                physics: BouncingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (cntx, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: this.state.screen.width * .75,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Mis adelantos',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 102, 1),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/advance-periodic');
                        },
                        child: MyAdvanceAfter(date: new DateTime(2020, 6, 15), total: 950),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: this.state.screen.width * .55,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Adelantos anteriores',
                            style: TextStyle(
                              color: Color.fromRGBO(142, 145, 162, 1),
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Column(
                          children: [
                            MyAdvanceBefore(date: new DateTime(2020, 4, 2, 8, 10, 0), folio: 3356, total: 1500),
                            MyAdvanceBefore(date: new DateTime(2020, 2, 25, 7, 24, 0), folio: 1298, total: 800),
                            MyAdvanceBefore(date: new DateTime(2020, 1, 13, 10, 12, 0), folio: 1167, total: 10000)
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}