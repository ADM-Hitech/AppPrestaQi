import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/settings_info_account/page.dart';
import 'package:prestaqi/utils/hexcolor.dart';

Widget settingInfoAccountBody({
  required SettingInfoAccountState state,
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
                    child: Image.asset('assets/icons/ico-ajustes-informe.png', height: 90),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Text(
                    'Crea un informe de tus datos y movimientos en PrestaQi.',
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
                  'Crea un informe de todas las operaciones que hayas realizado con PrestaQi. Puedes acceder o transferir la información a otra aplicación. El informe no incluye configuraciones adicionales ni datos personales.',
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
              ),
              Center(
                child: Opacity(
                  opacity: state.loading ? .7 : 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 60),
                    width: width * .8,
                    child: GestureDetector(
                      onTap: state.loading ? () {} : state.downloadMyInfo,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('#000066'),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/icons/ico-boton-informe.svg',
                                color: const Color.fromRGBO(202, 206, 230, 1),
                                width: 23,
                              )
                            ),
                            const Center(
                              child: Text(
                                'SOLICITAR INFORME', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (state.loading) ...[
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 5,
                    width: width * .8,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(202, 206, 230, 1),
                      borderRadius: BorderRadius.circular(3.5)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Container(
                            height: 5,
                            width: (width * .8) * (state.porcen / 100),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(51, 51, 255, 1),
                              borderRadius: BorderRadius.circular(3.5)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]
            ],
          );
        },
      ),
    );
}