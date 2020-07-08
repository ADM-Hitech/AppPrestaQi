import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmLogoutModal extends ModalRoute<void> {

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

    return ConfirmLogout();
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

class ConfirmLogout extends StatefulWidget {
    
  @override
  ConfirmLogoutState createState() => ConfirmLogoutState();
}

class ConfirmLogoutState extends State<ConfirmLogout> {

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
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * .8,
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
          height: 420,
          child: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/ico-alerta.svg',
                    color: Color.fromRGBO(255, 51, 102, 1),
                    width: 80,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  child: Text('¿Cerrar la sesión?', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 102, 1),
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Center(
                        child: Text(
                          'CONTINUAR', 
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
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(198, 200, 208, 1),
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: Center(
                        child: Text(
                          'CANCELAR', 
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
        ),
      ),
    );
  }
}
