import 'package:flutter/material.dart';
import 'package:prestaqi/pages/setting_info_app/page.dart';

Widget settingInfoAppBody({
  required SettingInfoAppState state
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
                    child: Image.asset('assets/icons/ico-ajustes-info-plataforma.png', width: 90),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: Text(
                    'Versión ${state.version}',
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
                  'Con PrestaQi, en menos de 5 minutos contarás con tu dinero, sin trámites largos ni letras chiquitas. En todo momento mostramos cuánto pagarás, sin comisiones ni intereses ocultos. \n\n¡Pide tu adelanto ya!',
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
                  child: const Text(
                    'Consulta',
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
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    )
                  )
                ),
                child: GestureDetector(
                  onTap: state.showAvisoPrivacidad,
                  child: const Text(
                    'Aviso de privacidad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    )
                  )
                ),
                child: GestureDetector(
                  onTap: state.showTerminos,
                  child: const Text(
                    'Términos y condiciones',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    ),
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