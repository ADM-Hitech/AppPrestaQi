import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/AdvancePeriodic/advance_periodic.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';

class AdvancePeriodicContent extends StatelessWidget {
  
  final AdvancePeriodicState state;

  AdvancePeriodicContent({Key key, @required this.state});

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
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (cnxt, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 25, right: 25),
                margin: EdgeInsets.only(top: 50, bottom: 25),
                width: (this.state.screen.width * .7) + 25,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Mis adelantos del período',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 102, 1)
                    )
                  ),
                ),
              ),
              Container(
                width: this.state.screen.width,
                child: Container(
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Container(
                          
                          child: Text(
                            'FECHA',
                            textAlign: TextAlign.center
                          ),
                        )
                      ),
                      DataColumn(label: Center(child: Text('ADELANTO', textAlign: TextAlign.center,))),
                      DataColumn(label: Center(
                        child: Text(
                          'TOTAL\r\nA RETENER',
                          textAlign: TextAlign.center,
                        ),
                      )),
                      DataColumn(label: Center(child: Text('FOLIO', textAlign: TextAlign.center,)))
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Container(child: Center(child: Text('03/06/20')))
                          ),
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                appService<NavigationService>().showDetailsAdvancePeriodic(context);
                              },
                              child: Container(child: Center(child: Text('\$100'))),  
                            )
                          ),
                          DataCell(
                            Container(child: Center(child: Text('\$120')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('0045')))
                          )
                        ]
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Container(child: Center(child: Text('06/06/20')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('\$200')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('\$230')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('0067')))
                          )
                        ]
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Container(child: Center(child: Text('10/06/20')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('\$250')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('\$275')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('0189')))
                          )
                        ]
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Container(child: Center(child: Text('12/06/20')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('\$400')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('\$435')))
                          ),
                          DataCell(
                            Container(child: Center(child: Text('0234')))
                          )
                        ]
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 25),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(50, 55, 158, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('TOTAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('\$950', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('\$1,060', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Container(
                      width: 50,
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