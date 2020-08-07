import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/HexColor.dart';
import '../Utils/ScreenResponsive.dart';

class DrawerMenu extends StatefulWidget {

  final ScreenResponsive screen;
  final Function hideSlide;

  DrawerMenu({Key key, this.screen, this.hideSlide});

  @override
  DrawerMenuState createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {

  UserToken user;

  Future<SharedPreferences> sPrefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    this.getUser();
  }

  void getUser() {
    appService<AuthService>().me().then((value) {
      setState(() {
        this.user = value;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void goTo(String routeName, Object arguments) {
    appService<NavigationService>().navigateTo(routeName, arguments: arguments);
    widget.hideSlide();
  }

  void logAuth() async {
    var response = await appService<NavigationService>().showConfirmLogout(context) ?? false;

    if (response) {
      appService<AuthService>().logout().then((value) {
        appService<NavigationService>().navigateTo('/index-auth');
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  String letterName() {
    var split = this.user?.givenName?.split(' ');
    String letters = split != null ? (split[0][0] ?? '') + (split[1][0] ?? '') : '';

    return letters;
  }

  String getId() {
    if (this.user == null) {
      return '0000';
    }

    return this.user.userId.toString().padLeft(4, '0');
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.transparent,
      height: widget.screen.height,
      margin: EdgeInsets.only(
        top: widget.screen.heightAppBar / 2
      ),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 180,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Center(
                      child: Text(
                        this.letterName(),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          child: Text(
                            this.user == null ? '' : this.user.givenName, 
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Text(
                            'ID ${this.getId()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: HexColor.fromHex('#000066'),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(65)
              )
            )
          ),
          Container(
            height: widget.screen.height - 180 - widget.screen.heightAppBar / 2,
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 45),
            width: 300,
            color: Colors.white,
            child: Stack(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('/change-password', arguments: 1);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-candado.svg',
                                color: Color.fromRGBO(202, 206, 230, 1),
                                width: 20,
                              ),
                            ),
                            Container(
                              child: Text(
                                'Cambiar Contraseña',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (this.user != null && this.user.type == 2)
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/my-investments');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: SvgPicture.asset(
                                  'assets/icons/ico-inversiones.svg',
                                  color: Color.fromRGBO(202, 206, 230, 1),
                                  width: 20,
                                ),
                              ),
                              Container(
                                child: Text('Mis Inversiones', 
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: HexColor.fromHex('#000066'),
                                    fontSize: 18
                                  )
                                ),
                              )
                            ],
                          ),
                        )
                      )
                    ,
                    if (this.user != null && this.user.type == 3)
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/request-advance');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: SvgPicture.asset(
                                  'assets/icons/ico-menu-adelantos.svg',
                                  color: Color.fromRGBO(202, 206, 230, 1),
                                  width: 20,
                                ),
                              ),
                              Container(
                                child: Text('Solicitar Adelanto', 
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: HexColor.fromHex('#000066'),
                                    fontSize: 18
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ,
                    if (this.user != null && this.user.type == 3)
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('/my-advances');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: SvgPicture.asset(
                                  'assets/icons/ico-menu-adelantos.svg',
                                  color: Color.fromRGBO(202, 206, 230, 1),
                                  width: 20,
                                ),
                              ),
                              Container(
                                child: Text('Mis Adelantos', 
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: HexColor.fromHex('#000066'),
                                    fontSize: 18
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ,
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('/my-profile');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-perfil.svg',
                                color: Color.fromRGBO(202, 206, 230, 1),
                                width: 20,
                              ),
                            ),
                            Container(
                              child: Text('Mi Perfil',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                )
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('/technical-support');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-soporte-tecnico.svg',
                                color: Color.fromRGBO(202, 206, 230, 1),
                                width: 20,
                              ),
                            ),
                            Container(
                              child: Text('Soporte Técnico',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                )
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('/settings');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-ajustes.svg',
                                color: Color.fromRGBO(202, 206, 230, 1),
                                width: 20,
                              ),
                            ),
                            Container(
                              child: Text('Ajustes',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                )
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: this.logAuth,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-cerrar-sesion.svg',
                                color: Color.fromRGBO(202, 206, 230, 1),
                                width: 20,
                              ),
                            ),
                            Container(
                              child: Text('Cerrar Sesión',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                )
                              ),
                            )
                          ],
                        )
                      ),
                    )
                  ],
                ),
                /*Positioned(
                  bottom: 20,
                  child: Container(
                    width: (300 - 70).toDouble(),
                    child: Text('Últomo acceso 25 de mayo 2020 18:45 hrs.', 
                      style: TextStyle(
                        color: Color.fromRGBO(157, 160, 174, 1),
                        fontSize: 15
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )*/
              ],
            ),
          )
        ],
      ),
    );
  }
}