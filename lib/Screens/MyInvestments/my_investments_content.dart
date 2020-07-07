import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/MyInvestments/my_investments.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class MyInvestmentsContent extends StatelessWidget {

  final MyInvestmentsState state;

  MyInvestmentsContent({Key key, @required this.state});

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
              child: this.state.loading ?
              Center(
                child: CircularProgressIndicator(),
              ) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    width: this.state.screen.width * .8,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Mis inversiones',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 102, 1),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: this.state.screen.width,
                    color: Colors.white,
                    height: 67,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 56,
                          child: Container(
                            width: this.state.screen.width,
                            height: 10,
                            color: Color.fromRGBO(222, 227, 237, 1),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: TabBar(
                            isScrollable: true,
                            controller: this.state.tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 10,
                            tabs: this.state.investments.map((investment) => 
                              Tab(
                                child: Text(
                                  investment.capitalID.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 102, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  )
                                )
                              )
                            ).toList()
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: this.state.screen.width,
                    color: Colors.white,
                    height: this.state.screen.height,
                    child: TabBarView(
                      controller: this.state.tabController,
                      children: this.state.investments.map((investmen) => 
                        Container(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Inversión ${investmen.capitalID.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color.fromRGBO(40, 101, 255, 1)
                                  )
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
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
                                    Container(child: Text('Principal', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                    Container(child: Text('\$${investmen.amount}', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
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
                                    Container(child: Text('Tasa de interés anual', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                    Container(child: Text('${investmen.interestRate}%', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
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
                                    Container(child: Text('Pago de interés anual', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                    Container(child: Text('\$${investmen.annualInterestPayment}', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
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
                                    Container(child: Text('Intereses pagados + principal', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                    Container(child: Text('\$${investmen.total}', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
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
                                    Container(child: Text('Fecha inicial', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                    Container(child: Text(this.state.formatDate.format(investmen.startDate), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
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
                                    Container(child: Text('Fecha final', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                    Container(child: Text(this.state.formatDate.format(investmen.endDate), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(child: Text('Estatus', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                    Container(child: Text(investmen.enabled ? 'Activa' : 'Inactiva', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Container(
                                  width: this.state.screen.width * .8,
                                  child: GestureDetector(
                                    onTap: () {
                                      appService<NavigationService>().navigateTo('/details-investments', arguments: investmen.details);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 25),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex('#000066'),
                                        borderRadius: BorderRadius.circular(40)
                                      ),
                                      child: Center(
                                        child: Text(
                                          'VER DETALLE', 
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ).toList()
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}