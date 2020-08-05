import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/ConfirmRequestAdvance/confirm_request_advance.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';

class ConfirmRequestAdvanceContent extends StatelessWidget {

  final ConfirmRequestAdvanceState state;

  ConfirmRequestAdvanceContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60)
        )
      ),
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(239, 244, 255, 1),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: Color.fromRGBO(222, 227, 237, 1),
                    width: 2
                  )
                ),
                padding: EdgeInsets.all(40),
                width: this.state.screen.width * .65,
                child: Column(
                  children: [
                    Container(
                      child: Text('Cantidad solicitada',
                        style: TextStyle(
                          fontSize: 20, 
                          color: Color.fromRGBO(142, 145, 162, 1),
                          fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: this.state.screen.width * .65,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          '\$${this.state.getAmount()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 102, 1)
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 7,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(202, 206, 230, 1),
                        borderRadius: BorderRadius.circular(3.5)
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Container(
                              height: 7,
                              width: ((this.state.screen.width * .65) - 80) * this.state.porcen,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(51, 51, 255, 1),
                                borderRadius: BorderRadius.circular(3.5)
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 305,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: this.state.screen.width * .8,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(222, 227, 237, 1),
                            width: 1
                          ),
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Text('Banco', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                          Container(child: Text(this.state.infoBank.institutionName, style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(222, 227, 237, 1),
                            width: 1
                          ),
                        )
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Text('Cuenta', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                          Container(child: Text('**** **** ${this.state.getLast4Char()}', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(222, 227, 237, 1),
                            width: 1
                          ),
                        )
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Text('Total a descontar', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                          Container(child: Text('\$${this.state.getAmountDiscount()}', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Text('Fecha de cobro', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                          Container(child: Text(this.state.formatDate.format(this.state.dateNextPay), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          (this.state.loading) ?
            Center(
              child: CircularProgressIndicator(),
            )
          :
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: this.state.screen.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (this.state.screen.width * .8) / 2,
                      padding: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: this.state.loading ? (){} : this.state.acepted,
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 102, 1),
                            borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: Center(
                            child: Text('ACEPTAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: (this.state.screen.width * .8) / 2,
                      padding: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (!this.state.loading) {
                            appService<NavigationService>().navigateTo('/request-advance');
                          }
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(198, 200, 208, 1),
                            borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: Center(
                            child: Text('RECHAZAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}