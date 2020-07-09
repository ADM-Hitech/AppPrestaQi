import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/SettingInfoApp/setting_info_app.dart';

class SettingInfoAppContent extends StatelessWidget {

  final SettingInfoAppState state;

  SettingInfoAppContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60)
        )
      ),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (cntx, i) {
          return Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(239, 244, 255, 1),
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(
                      color: Color.fromRGBO(222, 227, 237, 1),
                      width: 1.5
                    ),
                    boxShadow: [
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
                  margin: EdgeInsets.only(top: 60),
                  child: Text(
                    'Versión 1.0',
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
                margin: EdgeInsets.only(top: 30),
                child: Text(
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
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
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
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    )
                  )
                ),
                child: Text(
                  'Aviso de privacidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(142, 145, 162, 1)
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    )
                  )
                ),
                child: Text(
                  'Términos y condiciones',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(142, 145, 162, 1)
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 60,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(222, 227, 237, 1),
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
}