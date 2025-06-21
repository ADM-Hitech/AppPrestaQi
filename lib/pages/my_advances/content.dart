import 'package:flutter/material.dart';
import 'package:prestaqi/pages/my_advances/page.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/hexcolor.dart';
import 'package:prestaqi/widgets/advances_after.widget.dart';
import 'package:prestaqi/widgets/advances_before.widget.dart';

Widget myAdvanceBody({
  required MyAdvanceState state
}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return SizedBox(
    height: height,
    width: width,
    child: Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            height: 290,
            width: width,
            decoration: BoxDecoration(
              color: HexColor.fromHex('#1292ff'),
              image: const DecorationImage(
                image: AssetImage('assets/images/background_header.png'),
                fit: BoxFit.none,
                alignment: Alignment.bottomCenter
              )
            )
          ),
        ),
        Positioned(
          top: 125,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: HexColor.fromHex('#eff4ff'),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(70)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 102, .4),
                  spreadRadius: 5,
                  blurRadius: 50,
                  offset: Offset(0, 3)
                )
              ]
            ),
            child: state.loading ? const Center(
              child: CircularProgressIndicator(),
            ) : ListView.builder(
              padding: const EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 0),
              physics: const BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (cntx, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * .75,
                      child: const FittedBox(
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
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (state.forPayment.id != 0) {
                          appService<NavigationService>().showDetailForPayment(state.context, state.forPayment);
                        } else {
                          appService<NavigationService>().navigateTo('advance-periodic', arguments: state.advancesActive);
                        }
                      },
                      child: AdvancesAfter(
                        date: DateTime(state.date.year, state.date.month, state.nextDayForPay),
                        total: state.totalDiscount,
                        sizeText: state.getFontSize(width),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: width * .55,
                      child: const FittedBox(
                        fit: BoxFit.contain,
                        child: Text('Adelantos anteriores',
                          style: TextStyle(
                            color: Color.fromRGBO(142, 145, 162, 1),
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: state.advances.map((advance) => 
                        GestureDetector(
                          onTap: () {
                            appService<NavigationService>().showDetailsAdvancePeriodic(state.context, advance);
                          },
                          child: AdvancesBefore(
                            date: advance.dateAdvance,
                            folio: advance.id,
                            total: advance.totalWithhold,
                            sizeText: state.getFontSize(width),
                          ),
                        )
                      ).toList(),
                    ),
                    SizedBox(height: 160,)
                  ],
                );
              },
            ),
          )
        )
      ],
    ),
  );
}