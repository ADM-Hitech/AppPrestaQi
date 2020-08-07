import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Models/DataAdvanceCapitalNotification.dart';
import 'package:prestaQi/Models/MyProfile.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Services/UserService.dart';

class CartaMandatoInversionistaModal extends ModalRoute<void> {

  final DataAdvanceCapitalNotification info;

  CartaMandatoInversionistaModal({this.info});

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

    return CartaMandato(info: this.info);
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

class CartaMandato extends StatefulWidget {

  final DataAdvanceCapitalNotification info;

  CartaMandato({this.info});
    
  @override
  CartaMandatoState createState() => CartaMandatoState();
}

class CartaMandatoState extends State<CartaMandato> {

  bool accept = false;
  bool decline = false;
  DateTime date = DateTime.now();
  DateFormat dateFormat = new DateFormat('dd/MM/yyyy');
  MyProfileModel user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    this.getUser();
  }

  void getUser() {
    appService<UserService>().getMyProfile().then((value) {
      setState(() {
        this.user = value;
        this.loading = false;
      });
    }).catchError((onError) {
      setState(() {
        this.loading = false;
      });
    });
  }

  int getAmount() {
    return this.widget.info.amount.floor();
  }

  String getDecimalAmount() {
    var decimal = (this.widget.info.amount - this.getAmount()).toString();
    var split = decimal.split('.');
    if (split.length > 1) {
      return split[1];
    }

    return '';
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
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                height: (MediaQuery.of(context).size.height * .9),
                child: this.loading ? 
                  Center(
                    child: CircularProgressIndicator(),
                  ) :
                  ListView.builder(
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
                              child: Text('C. ${this.user == null ? '' : this.user.firstName + ' ' + this.user.lastName}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 102, 1),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                            Container(
                              child: Text('PRESENTE.-',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 102, 1),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 25),
                              child: RichText(
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                text: TextSpan(
                                  text: 'POR MEDIO DE LA PRESENTE, AL AMPARO DEL CONTRATO DE MUTUO CON INTERÉS NÚMERO ${this.widget.info.capitalId.toString().padLeft(4, '0')} QUE CELEBRÓ CON MI REPRESENTADA EN FECHA',
                                  children: [
                                    TextSpan(text: ' ${this.dateFormat.format(this.user.startDatePrestaQi)}, LE SOLICITO PONGA A DISPOSICIÓN DE MI PRESENTADA LA CANTIDAD DE'),
                                    TextSpan(text: ' \$${this.getAmount()} (${this.getDecimalAmount().padLeft(2, '0')}/100 M.N),'),
                                    TextSpan(text: ' LA CUAL DEBERÁ EFECTUAR MEDIANTE DEPOSITO BANCARIO O TRANSFERENCIA ELECTRÓNICA DE FONDOS, A LA CUENTA BANCARIA NUMERO [*], DE LA INSTITUCIÓN BANCARIA DENOMINADA [*],'),
                                    TextSpan(text: ' CON CLABE INTERBANCARIA [*] A NOMBRE DE'),
                                    TextSpan(text: ' PRESTAQI, S.A.P.I DE C.V.,'),
                                    TextSpan(text: ' A FIN DE QUE SEA UTILIZADA PARA LOS FINES PRECISADOS EN EL CONTRATO REFERIDO.')
                                  ],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(142, 145, 162, 1)
                                  )
                                )
                              )
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 25),
                              child: RichText(
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                text: TextSpan(
                                  text: 'EL COMPROBANTE DE DEPÓSITO Y/O TRANSFERENCIA ELECTRÓNICA DE FONDOS A QUE SE REFIERE EL PÁRRAFO INMEDIATO ANTERIOR,',
                                  children: [
                                    TextSpan(text: ' JUNTO CON LA PRESENTE CARTA QUE SE LE NOTIFICA, HARÁ LAS VECES DEL RECIBO MAS AMPLIO Y EFICAZ QUE EN DERECHO CORRESPONDA'),
                                    TextSpan(text: ' HASTA POR IMPORTE QUE JUSTIFIQUE TAL COMPROBANTE.')
                                  ],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(142, 145, 162, 1),
                                  )
                                )
                              )
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 25),
                              child: Text(
                                'ATENTAMENTE:',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(142, 145, 162, 1)
                                )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 25),
                              alignment: Alignment.center,
                              child: Text(
                                '"EL MUTUATARIO"',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(142, 145, 162, 1)
                                )
                              )
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'FIRMA DEL MUTUATARIO,\n\rPOR CONDUCTO DE C. [*]\n\rAPODERADO LEGAR DE PRESTAQI, S.A.P.I DE C.V.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(142, 145, 162, 1)
                                )
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Checkbox(
                                      checkColor: this.accept ? Colors.white : Color.fromRGBO(0, 0, 102, 1),
                                      activeColor: this.accept ? Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                                      onChanged: (bool value) {
                                        setState(() {
                                          this.accept = value;
                                          this.decline = !value;
                                          Navigator.pop(context, true);
                                        });
                                      },
                                      value: this.accept
                                    )
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 151,
                                    child: Text('Sí, acepto los términos y condiciones señalados en la presente Carta Mandato.'),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Checkbox(
                                      checkColor: this.decline ? Colors.white : Color.fromRGBO(0, 0, 102, 1),
                                      activeColor: this.decline ? Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                                      onChanged: (bool value) {
                                        setState(() {
                                          this.decline = value;
                                          this.accept = !value;
                                          Navigator.pop(context, false);
                                        });
                                      },
                                      value: this.decline
                                    ),
                                  ),
                                  Container(
                                    child: Text('No estoy de acuerdo.'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
