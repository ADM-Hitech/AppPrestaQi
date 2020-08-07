import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/DetailsInvestments/details_investments.dart';

class DetailsInvestmentsContent extends StatelessWidget {

  final DetailsInvestmentsState state;

  DetailsInvestmentsContent({Key key, @required this.state});

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
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (cntx, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                width: this.state.screen.width * .65,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Estado de Cuenta',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 102, 1),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 25, right: 25),
                child: Text(
                  'Contrato de mutuo acuerdo con interés',
                  style: TextStyle(
                    color: Color.fromRGBO(77, 77, 77, 1),
                    fontSize: 16
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                width: this.state.screen.width,
                height: 1,
                color: Color.fromRGBO(222, 227, 237, 1),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Tasa de interés anual',
                        style: TextStyle(
                          color: Color.fromRGBO(77, 77, 77, 1),
                          fontSize: 19
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        '${this.state.widget.investment.interestRate}%',
                        style: TextStyle(
                          color: Color.fromRGBO(77, 77, 77, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: this.state.screen.width,
                height: (55 * (this.state.widget.investment.details.length + 1)).toDouble(),
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          color: Color.fromRGBO(239, 244, 255, 1),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                child: Center(
                                  child: Text(
                                    '#',
                                    style: TextStyle(
                                      color: Color.fromRGBO(77, 77, 77, 1),
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'INICIAL',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'VENCIMIENTO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'SALDO INSOLUTO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'PAGO PRINCIPAL',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'PAGO INTERESES',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'IVA INTERESES',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'RETENCIÓN IVA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'RETENCIÓN ISR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Text(
                                  'PAGO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: this.state.widget.investment.details.map((detail) => 
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(222, 227, 237, 1),
                                    width: 1
                                  ),
                                )
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        detail.period.toString(),
                                        style: TextStyle(
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      this.state.formatDate.format(detail.startDate),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      this.state.formatDate.format(detail.endDate),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${this.state.numberFormat.format(detail.outstandingBalance)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${this.state.numberFormat.format(detail.principalPayment)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${this.state.numberFormat.format(detail.interestPayment)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${this.state.numberFormat.format(detail.vat)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${this.state.numberFormat.format(detail.vatRetention)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${this.state.numberFormat.format(detail.isrRetention)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${this.state.numberFormat.format(detail.payment)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                          ).toList()
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}