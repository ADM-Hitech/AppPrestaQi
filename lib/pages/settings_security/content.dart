import 'package:flutter/material.dart';
import 'package:prestaqi/pages/settings_security/page.dart';

Widget settingsSecurityBody({
  required SettingSecurityState state,
}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 25),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(60)
      )
    ),
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (cntx, i) {
        return Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(239, 244, 255, 1),
                  borderRadius: BorderRadius.circular(80),
                  border: Border.all(
                    color: const Color.fromRGBO(222, 227, 237, 1),
                    width: 1.5
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(222, 227, 237, 1),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: Offset(-10, 10)
                    )
                  ]
                ),
                child: Center(
                  child: Image.asset('assets/icons/ico-ajustes-seguridad.png', width: 90),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Text(
                  'Tus datos están protegidos con un cifrado de seguridad.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color.fromRGBO(0, 0, 102, 1)
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Todas las operaciones y tus datos personales están protegidos con cifrado y autenticación por medio de token por lo que es completamente seguro realizar operaciones en nuestra plataforma. \n\nEn PrestaQi nos preocupamos por tu seguridad y estamos contigo en todo momento.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(142, 145, 162, 1)
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: 60,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(222, 227, 237, 1),
                  borderRadius: BorderRadius.circular(4)
                ),
              ),
            )
          ],
        );
      },
    ),
  );
}