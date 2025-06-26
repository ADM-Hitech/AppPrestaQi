import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestaqi/models/data_advance_capital_notification.model.dart';
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/setup.service.dart';

class CartaMandatoInversionistaModal extends ModalRoute<void> {

  final DataAdvanceCapitalNotificationModel info;

  CartaMandatoInversionistaModal({required this.info});

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

    return CartaMandato(info: info);
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

  final DataAdvanceCapitalNotificationModel info;

  const CartaMandato({super.key, required this.info});
    
  @override
  CartaMandatoState createState() => CartaMandatoState();
}

class CartaMandatoState extends State<CartaMandato> {

  bool accept = false;
  bool decline = false;
  DateTime date = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  late MyProfileModel user;
  bool loading = true;
  NumberFormat numberFormat = NumberFormat.currency(symbol: '', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    appService<AppService>().getMyProfile().then((value) {
      setState(() {
        user = value;
        loading = false;
      });
    }).catchError((onError) {
      setState(() {
        loading = false;
      });
    });
  }

  int getAmount() {
    return widget.info.amount.floor();
  }

  String getDecimalAmount() {
    var decimal = (widget.info.amount - getAmount()).toString();
    var split = decimal.split('.');
    if (split.length > 1) {
      return split[1];
    }

    return '';
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
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              height: (MediaQuery.of(context).size.height * .9),
              child: loading ? 
                const Center(
                  child: CircularProgressIndicator(),
                ) :
                ListView.builder(
                  itemCount: 1,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctnx, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('C. ${user == null ? '' : '${user.firstName} ${user.lastName}'}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color.fromRGBO(0, 0, 102, 1),
                              fontSize: 19,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          const Text('PRESENTE.-',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 102, 1),
                              fontSize: 19,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 25),
                            child: RichText(
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              text: TextSpan(
                                text: 'POR MEDIO DE LA PRESENTE, AL AMPARO DEL CONTRATO DE MUTUO CON INTERÉS NÚMERO ${widget.info.capitalId.toString().padLeft(4, '0')} QUE CELEBRÓ CON MI REPRESENTADA EN FECHA',
                                children: [
                                  TextSpan(text: ' ${dateFormat.format(user.startDatePrestaQi)}, LE SOLICITO PONGA A DISPOSICIÓN DE MI PRESENTADA LA CANTIDAD DE'),
                                  TextSpan(text: ' \$${numberFormat.format(getAmount())} (${getDecimalAmount().padLeft(2, '0')}/100 M.N),'),
                                  const TextSpan(text: ' LA CUAL DEBERÁ EFECTUAR MEDIANTE DEPOSITO BANCARIO O TRANSFERENCIA ELECTRÓNICA DE FONDOS, A LA CUENTA BANCARIA NUMERO [*], DE LA INSTITUCIÓN BANCARIA DENOMINADA [*],'),
                                  const TextSpan(text: ' CON CLABE INTERBANCARIA [*] A NOMBRE DE'),
                                  const TextSpan(text: ' PRESTAQI, S.A.P.I DE C.V.,'),
                                  const TextSpan(text: ' A FIN DE QUE SEA UTILIZADA PARA LOS FINES PRECISADOS EN EL CONTRATO REFERIDO.')
                                ],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(142, 145, 162, 1)
                                )
                              )
                            )
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 25),
                            child: RichText(
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              text: const TextSpan(
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
                            margin: const EdgeInsets.only(bottom: 25),
                            child: const Text(
                              'ATENTAMENTE:',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(142, 145, 162, 1)
                              )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            alignment: Alignment.center,
                            child: const Text(
                              '"EL MUTUATARIO"',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(142, 145, 162, 1)
                              )
                            )
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'FIRMA DEL MUTUATARIO,\n\rPOR CONDUCTO DE C. [*]\n\rAPODERADO LEGAR DE PRESTAQI, S.A.P.I DE C.V.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(142, 145, 162, 1)
                              )
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: accept ? Colors.white : const Color.fromRGBO(0, 0, 102, 1),
                                activeColor: accept ? const Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                                onChanged: (bool? value) {
                                  setState(() {
                                    accept = value ?? false;
                                    decline = !(value ?? false);
                                    Navigator.pop(context, true);
                                  });
                                },
                                value: accept
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 151,
                                child: const Text('Sí, acepto los términos y condiciones señalados en la presente Carta Mandato.'),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: decline ? Colors.white : const Color.fromRGBO(0, 0, 102, 1),
                                activeColor: decline ? const Color.fromRGBO(50, 55, 158, 1) : Colors.white,
                                onChanged: (bool? value) {
                                  setState(() {
                                    decline = value ?? false;
                                    accept = !(value ?? false);
                                    Navigator.pop(context, false);
                                  });
                                },
                                value: decline
                              ),
                              const Text('No estoy de acuerdo.')
                            ],
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
    );
  }
}
