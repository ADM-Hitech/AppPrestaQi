import 'package:flutter/material.dart';

class AlertSuccessModal extends ModalRoute<void> {

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
    return const AlertAccess();
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

class AlertAccess extends StatefulWidget {
  const AlertAccess({super.key});

  @override
  AlertAccessState createState() => AlertAccessState();
}

class AlertAccessState extends State<AlertAccess> {

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
        height: 400,
        child: Column(
          children: <Widget>[
            Center(
              child: Image.asset('assets/icons/circle_success.png', width: 70, height: 70),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('¡Listo!', 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28
              )
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 25),
              child: const Text(
                'Solicitud en curso, recibirás una notificación cuando tengas el dinero en tu cuenta.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(142, 145, 162, 1)
                )
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
            )
          ],
        ),
      ),
    );
  }
}
