import 'package:flutter/material.dart';

class DetailsAdvancePeriodicModal extends ModalRoute<void> {

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

    return DetailsAdvance();
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
    
  @override
  DetailsAdvanceState createState() => DetailsAdvanceState();
}

class DetailsAdvanceState extends State<DetailsAdvance> {

  bool accept = false;
  bool decline = false;

  @override
  void initState() {
    super.initState();
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
                                  child: Text('FOLIO 0045',
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
                                        )
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
                                          '\$100.00',
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
                                        Container(child: Text('Citybanamex', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('**** **** 1234', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('15%', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('\$15.00', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('\$5.00', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('\$120.00', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('03/06/20', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
                                        Container(child: Text('Fecha de cobro', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text('15/06/20', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(child: Text('Folio', style: TextStyle(color: Color.fromRGBO(142, 145, 162, 1), fontSize: 18))),
                                        Container(child: Text('0045', style: TextStyle(color: Color.fromRGBO(77, 77, 77, 1), fontSize: 18, fontWeight: FontWeight.bold)))
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
      ),
    );
  }
}
