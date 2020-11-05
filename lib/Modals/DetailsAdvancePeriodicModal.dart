import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/Advance.dart';
import 'package:prestaQi/Models/InfoBank.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Services/UserService.dart';

class DetailsAdvancePeriodicModal extends ModalRoute<void> {

  final Advance myAdvanceModel;

  DetailsAdvancePeriodicModal({this.myAdvanceModel});

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.4);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {

    return DetailsAdvance(myAdvanceModel: this.myAdvanceModel);
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class DetailsAdvance extends StatefulWidget {

  final Advance myAdvanceModel;

  DetailsAdvance({this.myAdvanceModel});
    
  @override
  DetailsAdvanceState createState() => DetailsAdvanceState();
}

class DetailsAdvanceState extends State<DetailsAdvance> {

  bool accept = false;
  bool decline = false;
  DateFormat formatDate = new DateFormat('dd/MM/yyyy');
  int nextDayForPay = 15;
  DateUtil dateUtil = new DateUtil();
  DateTime date = DateTime.now();
  bool loading = true;
  InfoBank infoBank = new InfoBank(accountNumber: '0000', institutionName: '', clabe: '');

  @override
  void initState() {
    super.initState();
    if (this.date.day > 15) {
      this.nextDayForPay = dateUtil.daysInMonth(this.date.month, this.date.year);
    }

    setState(() {
      this.date = new DateTime(this.date.year, this.date.month, this.nextDayForPay);
    });

    this.fetchInfoBank();
  }

  void fetchInfoBank() {
    setState(() {
      this.loading = true;
    });

    appService<UserService>().getInfoBanck().then((value) {
      setState(() {
        this.infoBank = value;
      });
    }).catchError((onError) {
      print(onError);
    }).whenComplete(() {
      setState(() {
        this.loading = false;
      });
    });
  }

  String getLast4Char() {
    int length = this.infoBank.accountNumber.length;
    return this.infoBank.accountNumber.substring(length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .9,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                height: (MediaQuery.of(context).size.height * .9),
                child: ListView.builder(
                  itemCount: 1,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctnx, i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text('FOLIO ${this.widget.myAdvanceModel.id.toString().padLeft(4, '0')}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 102, 1),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.close,
                                      size: 43,
                                      color: Color.fromRGBO(202, 206, 230, 1),
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
                                width: MediaQuery.of(context).size.width * .65,
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
                                      width: MediaQuery.of(context).size.width * .65,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          NumberFormat('\$ #,##0.00', 'es_Us').format(this.widget.myAdvanceModel.amount),
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
                                              width: ((MediaQuery.of(context).size.width * .65) - 80) * .1,
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
                          SizedBox(
                            height: 25,
                          ),
                          (this.loading) ?
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          :
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * .8,
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
                                        Container(child: Text(this.infoBank.institutionName, style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('**** **** ${this.getLast4Char()}', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('Tasa de interés', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text('${this.widget.myAdvanceModel.interestRate}%', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('Interés', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text(NumberFormat('\$ #,##0.00', 'es_Us').format(this.widget.myAdvanceModel.interest), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('Comisión', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text(NumberFormat('\$ #,##0.00', 'es_Us').format(this.widget.myAdvanceModel.comission), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('IVA', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text(NumberFormat('\$ #,##0.00', 'es_Us').format(this.widget.myAdvanceModel.vat), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('Total a Pagar', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text(NumberFormat('\$ #,##0.00', 'es_Us').format(this.widget.myAdvanceModel.totalWithhold), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('Fecha de solicitud', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text(formatDate.format(this.widget.myAdvanceModel.dateAdvance), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                      ],
                                    ),
                                  ),
                                  if (!(this.widget.myAdvanceModel.detailsByAdvance != null && this.widget.myAdvanceModel.detailsByAdvance.length > 0))
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
                                          Container(child: Text('Fecha de cobro', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                          Container(child: Text(formatDate.format(this.date), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                        ],
                                      ),
                                    )
                                  ,
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(child: Text('Folio', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text(this.widget.myAdvanceModel.id.toString().padLeft(4, '0'), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                      ],
                                    ),
                                  ),
                                  if (this.widget.myAdvanceModel.detailsByAdvance != null && this.widget.myAdvanceModel.detailsByAdvance.length > 0) ...[
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 20),
                                      child: Text('Fechas de cobro', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 20, fontWeight: FontWeight.bold))
                                    ),
                                    Column(
                                        children: this.widget.myAdvanceModel.detailsByAdvance.map((detail) =>
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(child: Text(formatDate.format(detail.datePayment), style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                              ],
                                            ),
                                          )
                                        ).toList(),
                                      )
                                  ]
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
