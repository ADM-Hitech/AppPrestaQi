import 'package:flutter/material.dart';
import 'package:prestaqi/pages/advance_periodic/page.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';

Widget advancePeriodicBody({
  required AdvancePeriodicState state
}) {

  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60)
        )
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (cnxt, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                margin: const EdgeInsets.only(top: 50, bottom: 25),
                width: (width * .7) + 25,
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Mis adelantos del periodo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 102, 1)
                    )
                  ),
                ),
              ),
              SizedBox(
                width: width,
                height: ((state.childs.length + 1) * 55).toDouble(),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'FECHA',
                            textAlign: TextAlign.center
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
                      rows: state.childs.map((advance) => 
                        DataRow(
                          cells: [
                            DataCell(
                              Center(child: Text(state.formatDate.format(advance.created)))
                            ),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  appService<NavigationService>().showDetailsAdvancePeriodic(state.context, advance);
                                },
                                child: Center(child: Text('\$${state.numberFormat.format(advance.amount)}', style: const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline))),  
                              )
                            ),
                            DataCell(
                              Center(child: Text('\$${state.numberFormat.format(advance.totalWithhold)}'))
                            ),
                            DataCell(
                              Center(child: Text(advance.id.toString().padLeft(4, '0')))
                            )
                          ]
                        )
                      ).toList()
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(50, 55, 158, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('TOTAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        '\$${state.numberFormat.format(state.totalAdvance)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: state.getFontSize(width)
                        )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        '\$${state.numberFormat.format(state.totalRetencion)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: state.getFontSize(width)
                        )
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
}