import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/TechnicalSupport/technical_support.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class TechnicalSupportContent extends StatelessWidget {

  final TechnicalSupportState state;

  TechnicalSupportContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 290,
              width: this.state.screen.width,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1292ff'),
                image: DecorationImage(
                  image: AssetImage('assets/images/background_header.png'),
                  fit: BoxFit.none,
                  alignment: Alignment.bottomCenter
                )
              ),
            ),
          ),
          Positioned(
            top: 95.0,
            child: Container(
              width: this.state.screen.width,
              height: this.state.screen.height,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: HexColor.fromHex('#eff4ff'),
                borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 102, .4),
                    spreadRadius: 5,
                    blurRadius: 50,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 0),
                physics: BouncingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (ctnx, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: this.state.screen.width * .75,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Soporte técnico',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 102, 1),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: this.state.screen.width * .9,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(77, 77, 77, .2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(-7, 10)
                                )
                              ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(102, 204, 102, 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: new LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color.fromRGBO(60, 162, 60, 1),
                                          Color.fromRGBO(102, 204, 102, 1),
                                        ]
                                      )
                                    ),
                                    child: Align(
                                      child: SvgPicture.asset(
                                        'assets/icons/ico-soporte-whatsapp.svg',
                                        color: Colors.white,
                                        width: 45,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Comunícate vía',
                                          style: TextStyle(
                                            color: Color.fromRGBO(142, 145, 162, 1),
                                            fontSize: 18
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'WhatsApp al número',
                                          style: TextStyle(
                                            color: Color.fromRGBO(142, 145, 162, 1),
                                            fontSize: 18
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text('55 22-33 44-55',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Color.fromRGBO(0, 0, 102, 1)
                                          )
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
                      Container(
                        width: this.state.screen.width * .9,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(77, 77, 77, .2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(-7, 10)
                                )
                              ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(102, 204, 102, 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: new LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          HexColor.fromHex('#3333ff'),
                                          HexColor.fromHex('#33ccff'),
                                        ]
                                      )
                                    ),
                                    child: Align(
                                      child: SvgPicture.asset(
                                        'assets/icons/ico-soporte-correo.svg',
                                        color: Colors.white,
                                        width: 45,
                                      ),
                                    )
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Comunícate vía',
                                          style: TextStyle(
                                            color: Color.fromRGBO(142, 145, 162, 1),
                                            fontSize: 18
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text('soporte@prestaqi.com',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            color: Color.fromRGBO(0, 0, 102, 1)
                                          )
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
                      Container(
                        width: this.state.screen.width * .9,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(77, 77, 77, .2),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(-7, 10)
                                )
                              ]
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(102, 204, 102, 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: new LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          HexColor.fromHex('#3333ff'),
                                          HexColor.fromHex('#33ccff'),
                                        ]
                                      )
                                    ),
                                    child: Align(
                                      child: SvgPicture.asset(
                                        'assets/icons/ico-soporte-telefono.svg',
                                        color: Colors.white,
                                        width: 45,
                                      ),
                                    )
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Asistencia telefónica',
                                          style: TextStyle(
                                            color: Color.fromRGBO(142, 145, 162, 1),
                                            fontSize: 18
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'a los números',
                                          style: TextStyle(
                                            color: Color.fromRGBO(142, 145, 162, 1),
                                            fontSize: 18
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text('800 111 2222',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Color.fromRGBO(0, 0, 102, 1)
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}