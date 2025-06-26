import 'package:flutter/material.dart';
import 'package:in_date_utils/in_date_utils.dart';
import 'package:intl/intl.dart';
import 'package:prestaqi/models/details_advance.model.dart';

class DetailForPaymentPeriodicModal extends ModalRoute<void> {

  final DetailsAdvanceModel detail;

  DetailForPaymentPeriodicModal({ required this.detail });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withValues(alpha: 0.4);

  @override
  String? get barrierLabel => null;

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

    return DetailForPaymentPeriodic(detail: detail);
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

class DetailForPaymentPeriodic extends StatefulWidget {

  final DetailsAdvanceModel detail;

  const DetailForPaymentPeriodic({super.key,  required this.detail});

  @override
  DetailForPaymentPeriodicState createState() => DetailForPaymentPeriodicState();
}

class DetailForPaymentPeriodicState extends State<DetailForPaymentPeriodic> {

  bool accept = false;
  bool decline = false;
  DateFormat formatDate = DateFormat('dd/MM/yyyy');
  int nextDayForPay = 15;
  DateTime date = DateTime.now();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if (date.day > 15) {
      nextDayForPay = DTU.getDaysInMonth(date.year, date.month);
    }

    setState(() {
      date = DateTime(date.year, date.month, nextDayForPay);
    });
  }

  String getLast4Char() {
    int length = widget.detail.accountNumber.length;
    return widget.detail.accountNumber.substring(length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .9,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              height: (MediaQuery.of(context).size.height * .9),
              child: ListView.builder(
                itemCount: 1,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctnx, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('FOLIO ${widget.detail.id.toString().padLeft(4, '0')}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color.fromRGBO(0, 0, 102, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                size: 43,
                                color: Color.fromRGBO(202, 206, 230, 1),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(239, 244, 255, 1),
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(
                                color: const Color.fromRGBO(222, 227, 237, 1),
                                width: 2
                              )
                            ),
                            padding: const EdgeInsets.all(40),
                            width: MediaQuery.of(context).size.width * .65,
                            child: Column(
                              children: [
                                const Text('Cantidad',
                                  style: TextStyle(
                                    fontSize: 20, 
                                    color: Color.fromRGBO(142, 145, 162, 1),
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .65,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      NumberFormat('\$ #,##0.00', 'es_Us').format(widget.detail.totalPayment),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 0, 102, 1)
                                      )
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(202, 206, 230, 1),
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
                                            color: const Color.fromRGBO(51, 51, 255, 1),
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
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
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
                                      const Text('Banco', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18)),
                                      Text(widget.detail.bankName, style: const TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(222, 227, 237, 1),
                                        width: 1
                                      ),
                                    )
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Cuenta', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18)),
                                      Text('**** **** ${getLast4Char()}', style: const TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(222, 227, 237, 1),
                                        width: 1
                                      ),
                                    )
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Interés', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18)),
                                      Text(NumberFormat('\$ #,##0.00', 'es_Us').format(widget.detail.interest), style: const TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(222, 227, 237, 1),
                                        width: 1
                                      ),
                                    )
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('IVA', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18)),
                                      Text(NumberFormat('\$ #,##0.00', 'es_Us').format(widget.detail.vat), style: const TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(222, 227, 237, 1),
                                        width: 1
                                      ),
                                    )
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Total a Pagar', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18)),
                                      Text(NumberFormat('\$ #,##0.00', 'es_Us').format(widget.detail.totalPayment), style: const TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(222, 227, 237, 1),
                                        width: 1
                                      ),
                                    )
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Fecha de cobro', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18)),
                                      Text(formatDate.format(widget.detail.datePayment), style: const TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Folio', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18)),
                                      Text(widget.detail.id.toString().padLeft(4, '0'), style: const TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold))
                                    ],
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
              ),
            )
          ],
        ),
      ),
    );
  }
}