import 'package:flutter/material.dart';
import 'package:prestaQi/Models/InfoBank.dart';

class CartaMandatoModal extends ModalRoute<void> {

  final InfoBank infoBank;

  CartaMandatoModal({this.infoBank});

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

    return CartaMandato(infoBank: this.infoBank);
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

  final InfoBank infoBank;

  CartaMandato({this.infoBank});
    
  @override
  CartaMandatoState createState() => CartaMandatoState();
}

class CartaMandatoState extends State<CartaMandato> {

  bool accept = false;
  bool decline = false;
  DateTime date = DateTime.now();
  List month = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];

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
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
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
                            child: Text('CARTA MANDATO',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 102, 1),
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            child: Text('Código: ${this.widget.infoBank.accountNumber}', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22
                              )
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 25),
                            child: Text(
                              'Yo, el señor ${this.widget.infoBank.firstName} ${this.widget.infoBank.lastName}, en mi calidad de Beneficiario del programa de adelanto de nóminas PrestaQi S.A.P.I de C.V., por medio de esta Carta Mandato reconozco que solicité al día de hoy ${this.date.day} de ${this.month[this.date.month + 1]} del año ${this.date.year}, la cantidad de MXN \$${this.widget.infoBank.amount.toStringAsFixed(2)} a la campañia PrestaQi S.A.P.I de C.V., adhiriendo esta operación a la regulación de las cláusulas establecidas en el contrato número ${this.widget.infoBank.contractNumber} que llevaron a cabo ${this.widget.infoBank.companyName} y PrestaQi S.A.P.I de C.V., al cual me adherí en sus términos al suscribirme a dicho programa a tráves de la Carta de Aviso General, por lo que instruyo a ${this.widget.infoBank.companyName} a retener dicha cantidad más los intereses y comisiones generados a partir de la aplicación de la siguiente fórmula:',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(142, 145, 162, 1)
                              )
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 25),
                            child: Text(
                              'Incluir fórmula o tabla de amortización:',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(142, 145, 162, 1)
                              )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'XXXXXXXXXXXXXXXXXXXXXXXX',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(142, 145, 162, 1)
                              )
                            )
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Dicha retención de \$${this.widget.infoBank.amount.toStringAsFixed(2)} se deberá llevar a cabo al término del presente periodo de pago de quincena y se le deberá entregar integro a PrestaQi S.A.P.I. de C.V.',
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
