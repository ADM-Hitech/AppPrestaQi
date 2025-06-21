import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/settings_delete_account/page.dart';

import '../../utils/hexcolor.dart';

Widget settingDeleteAccountBody({
  required SettingsDeleteAccountState state
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
                  child: Image.asset('assets/icons/ico-ajustes-eliminar-cuenta.png', width: 90),
                ),
              ),
            ),
            Center(
              child: Container(
                width: width * .8,
                margin: const EdgeInsets.only(top: 60),
                child: const Text(
                  'Si eliminas tu cuenta se borrarán:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color.fromRGBO(0, 0, 102, 1)
                  ),
                ),
              ),
            ),
            if (state.loading) ...[
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: CircularProgressIndicator(),
              )
            ] else ...[
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text(
                  'Tu cuenta de PrestaQi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(142, 145, 162, 1)
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  state.user.typeName == 'Acreditado' ? 'Tu historia de adelantos.' : 'Tu historia de inversiones.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(142, 145, 162, 1)
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Tus notificaciones.',
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
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  width: width * .8,
                  child: GestureDetector(
                    onTap: state.deleteMyAccount,
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
                              'assets/icons/ico-borrar.svg',
                              color: Color.fromRGBO(202, 206, 230, 1),
                              width: 23,
                            )
                          ),
                          const Center(
                            child: Text(
                              'SOLICITAR ELIMINACIÓN', 
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
              )
            ]
          ],
        );
      },
    ),
  );
}