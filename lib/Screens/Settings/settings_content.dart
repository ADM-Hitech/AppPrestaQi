import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/Settings/settings.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class SettingsContent extends StatelessWidget {
  
  final SettingsState state;

  SettingsContent({Key key, @required this.state});

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
              )
            ),
          ),
          Positioned(
            top: 95.0,
            child: Container(
              width: this.state.screen.width,
              height: this.state.screen.height,
              decoration: BoxDecoration(
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
                padding: EdgeInsets.only(top: 15, left: 0, right: 0, bottom: 0),
                physics: BouncingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (ctnx, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: this.state.screen.width * .5,
                        padding: EdgeInsets.all(25),
                        child: FittedBox(
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
                        width: this.state.screen.width,
                        child: Container(
                          width: this.state.screen.width,
                          height: 1,
                          color: Color.fromRGBO(222, 227, 237, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/setting-security');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/icons/ico-ajustes-seguridad.png',
                                        width: 50,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Seguridad',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 102, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: SvgPicture.asset(
                                  'assets/icons/ico-flecha-derecha.svg',
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  width: 18,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: this.state.screen.width,
                        child: Container(
                          width: this.state.screen.width,
                          height: 1,
                          color: Color.fromRGBO(222, 227, 237, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/setting-info-account');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      child: Image.asset(
                                        'assets/icons/ico-ajustes-informe.png',
                                        height: 50,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Informe de mi cuenta',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 102, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: SvgPicture.asset(
                                  'assets/icons/ico-flecha-derecha.svg',
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  width: 18,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: this.state.screen.width,
                        child: Container(
                          width: this.state.screen.width,
                          height: 1,
                          color: Color.fromRGBO(222, 227, 237, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/setting-info-app');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/icons/ico-ajustes-info-plataforma.png',
                                        width: 50,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Información de la app',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 102, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: SvgPicture.asset(
                                  'assets/icons/ico-flecha-derecha.svg',
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  width: 18,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: this.state.screen.width,
                        child: Container(
                          width: this.state.screen.width,
                          height: 1,
                          color: Color.fromRGBO(222, 227, 237, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/setting-delete-account');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        'assets/icons/ico-ajustes-eliminar-cuenta.png',
                                        width: 50,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Eliminar cuenta',
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 102, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: SvgPicture.asset(
                                  'assets/icons/ico-flecha-derecha.svg',
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  width: 18,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: this.state.screen.width,
                        child: Container(
                          width: this.state.screen.width,
                          height: 1,
                          color: Color.fromRGBO(222, 227, 237, 1),
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
}