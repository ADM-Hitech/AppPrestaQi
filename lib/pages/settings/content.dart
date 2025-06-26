import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/settings/page.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/hexcolor.dart';

Widget settingsBody({
  required SettingsState state,
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
            )
          ),
        ),
        Positioned(
          top: 125,
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Colors.white,
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
              padding: const EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 0),
              physics: const BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (ctnx, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * .5,
                      padding: const EdgeInsets.all(25),
                      child: const FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Ajustes',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 102, 1),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: Container(
                        width: width,
                        height: 1,
                        color: const Color.fromRGBO(222, 227, 237, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('setting-security');
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            appService<NavigationService>().navigateTo('setting-security');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/ico-ajustes-seguridad.png',
                                    width: 50,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      'Seguridad',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 102, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/icons/ico-flecha-derecha.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(142, 145, 162, 1), BlendMode.srcIn),
                                width: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: Container(
                        width: width,
                        height: 1,
                        color: const Color.fromRGBO(222, 227, 237, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('setting-info-account');
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            appService<NavigationService>().navigateTo('setting-info-account');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Image.asset(
                                      'assets/icons/ico-ajustes-informe.png',
                                      height: 50,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      'Informe de mi cuenta',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 102, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/icons/ico-flecha-derecha.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(142, 145, 162, 1), BlendMode.srcIn),
                                width: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: Container(
                        width: width,
                        height: 1,
                        color: const Color.fromRGBO(222, 227, 237, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('setting-info-app');
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            appService<NavigationService>().navigateTo('setting-info-app');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/ico-ajustes-info-plataforma.png',
                                    width: 50,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      'Información de la app',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 102, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/icons/ico-flecha-derecha.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(142, 145, 162, 1), BlendMode.srcIn),
                                width: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: Container(
                        width: width,
                        height: 1,
                        color: const Color.fromRGBO(222, 227, 237, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('setting-delete-account');
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            appService<NavigationService>().navigateTo('setting-delete-account');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/ico-ajustes-eliminar-cuenta.png',
                                    width: 50,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      'Eliminar cuenta',
                                      style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 102, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: state.getFontSize(width)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/icons/ico-flecha-derecha.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(142, 145, 162, 1), BlendMode.srcIn),
                                width: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: Container(
                        width: width,
                        height: 1,
                        color: const Color.fromRGBO(222, 227, 237, 1),
                      ),
                    ),
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