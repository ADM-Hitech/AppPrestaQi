import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmDeleteAccountModal extends ModalRoute<void> {

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.4);

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

    return const ConfirmDeleteAccount();
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

class ConfirmDeleteAccount extends StatefulWidget {
  const ConfirmDeleteAccount({super.key});

  @override
  ConfirmDeleteAccountState createState() => ConfirmDeleteAccountState();
}

class ConfirmDeleteAccountState extends State<ConfirmDeleteAccount> {

  bool accept = false;
  bool decline = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * .8,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        height: 509,
        child: Column(
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                'assets/icons/ico-alerta.svg',
                color: const Color.fromRGBO(255, 51, 102, 1),
                width: 80,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('¿Estás seguro?', 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              )
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 25),
              child: const Text(
                'Un asesor de PrestaQi te contactará vía telefónico o correo electrónico para indicarte los pasos a seguir para eliminar tu cuenta.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(142, 145, 162, 1)
                )
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 102, 1),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: const Center(
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
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(198, 200, 208, 1),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: const Center(
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
    );
  }
}
