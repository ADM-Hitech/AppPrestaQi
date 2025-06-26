import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/technical_support/page.dart';

import '../../utils/hexcolor.dart';

Widget technicalSupportBody({
  required TechnicalSupportState state,
}) {

  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 290,
              width: width,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1292ff'),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background_header.png'),
                  fit: BoxFit.none,
                  alignment: Alignment.bottomCenter
                )
              ),
            ),
          ),
          Positioned(
            top: 125,
            child: Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: HexColor.fromHex('#eff4ff'),
                borderRadius: const BorderRadius.only(topRight: Radius.circular(70)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 102, .4),
                    spreadRadius: 5,
                    blurRadius: 50,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 0),
                physics: const BouncingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (ctnx, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * .75,
                        child: const FittedBox(
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
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: width * .9,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
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
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: state.getSizeCircleIcon(width),
                                    height: state.getSizeCircleIcon(width),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(102, 204, 102, 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: const LinearGradient(
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
                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                        width: state.getSizeIcon(width),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Comunícate vía',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(142, 145, 162, 1),
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                    Text(
                                      'WhatsApp al número',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(142, 145, 162, 1),
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                    Text('55 9225 2019',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.getFontSizeData(width),
                                        color: const Color.fromRGBO(0, 0, 102, 1)
                                      )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: width * .9,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
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
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: state.getSizeCircleIcon(width),
                                    height: state.getSizeCircleIcon(width),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(102, 204, 102, 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
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
                                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                        width: state.getSizeIcon(width)
                                      ),
                                    )
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Comunícate vía',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(142, 145, 162, 1),
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                    SizedBox(
                                      width: (width * .9) - 110 - state.getSizeIcon(width),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text('soporte@prestaqi.com',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: state.getFontSizeData(width),
                                            color: const Color.fromRGBO(0, 0, 102, 1),
                                          ),
                                          maxLines: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      /*SizedBox(
                        width: width * .9,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
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
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: state.getSizeCircleIcon(width),
                                    height: state.getSizeCircleIcon(width),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(102, 204, 102, 1),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
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
                                        width: state.getSizeIcon(width),
                                      ),
                                    )
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Asistencia telefónica',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(142, 145, 162, 1),
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                    Text(
                                      'a los números',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(142, 145, 162, 1),
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                    Text('55 9225 2019',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.getFontSizeData(width),
                                        color: const Color.fromRGBO(0, 0, 102, 1)
                                      )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )*/
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