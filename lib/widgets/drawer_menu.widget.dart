import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/models/user_token.model.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:provider/provider.dart';

import '../providers/notification.provider.dart';
import '../services/navigation.service.dart';
import '../services/setup.service.dart';
import '../utils/hexcolor.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({ super.key });

  @override
  DrawerMenuState createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {

  UserTokenModel user = UserTokenModel();
  PreferenceUser sPrefs = PreferenceUser();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    appService<AppService>().me().then((value) {
      setState(() {
        user = value;
      });
    }).catchError((onError) {
      
    });
  }

  void goTo(String routeName, Object arguments) {
    appService<NavigationService>().navigateTo(routeName, arguments: arguments);
    //widget.hideSlide();
  }

  void logAuth() async {
    var response = await appService<NavigationService>().showConfirmLogout(context) ?? false;
    var pNotification = Provider.of<NotificationProvider>(context, listen: false);

    setState(() {
      pNotification.clearAlert();
    });

    if (response) {
      appService<AppService>().logout();
      appService<NavigationService>().navigateTo('index-auth');
    }
  }

  String letterName() {
    var split = user.givenName.split(' ');
    String letters = split.length > 1 ? (split[0][0]) + (split[1][0]) : '';

    return letters;
  }

  String getId() {
    if (user == null) {
      return '0000';
    }

    return user.userId.toString().padLeft(4, '0');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    
    return Container(
      color: Colors.transparent,
      height: height,
      margin: const EdgeInsets.only(
        top: 35
      ),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 180,
            decoration: BoxDecoration(
              color: HexColor.fromHex('#000066'),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(65)
              )
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Center(
                      child: Text(
                        letterName(),
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          user == null ? '' : user.givenName, 
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'ID ${getId()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ),
          Container(
            height: height - 180 - 70 / 2,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 45),
            width: 300,
            color: Colors.white,
            child: Stack(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('change-password', arguments: 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-candado.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                width: 20,
                              ),
                            ),
                            Text(
                              'Cambiar Contraseña',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('#000066'),
                                fontSize: 18
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (user != null && user.type == 2)
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('my-investments');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: SvgPicture.asset(
                                  'assets/icons/ico-inversiones.svg',
                                  colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                  width: 20,
                                ),
                              ),
                              Text('Mis Inversiones', 
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                )
                              )
                            ],
                          ),
                        )
                      )
                    ,
                    if (user != null && user.type == 3)
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('request-advance');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: SvgPicture.asset(
                                  'assets/icons/ico-menu-adelantos.svg',
                                  colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                  width: 20,
                                ),
                              ),
                              Text('Solicitar Adelanto', 
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    ,
                    if (user != null && user.type == 3)
                      GestureDetector(
                        onTap: () {
                          appService<NavigationService>().navigateTo('my-advances');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: SvgPicture.asset(
                                  'assets/icons/ico-menu-adelantos.svg',
                                  colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                  width: 20,
                                ),
                              ),
                              Text('Mis Adelantos', 
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#000066'),
                                  fontSize: 18
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    ,
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('profile');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-perfil.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                width: 20,
                              ),
                            ),
                            Text('Mi Perfil',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('#000066'),
                                fontSize: 18
                              )
                            )
                          ],
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('technical-support');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-soporte-tecnico.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                width: 20,
                              ),
                            ),
                            Text('Soporte Técnico',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('#000066'),
                                fontSize: 18
                              )
                            )
                          ],
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('settings');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-ajustes.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                width: 20,
                              ),
                            ),
                            Text('Ajustes',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('#000066'),
                                fontSize: 18
                              )
                            )
                          ],
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: logAuth,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/ico-menu-cerrar-sesion.svg',
                                colorFilter: ColorFilter.mode(const Color.fromRGBO(202, 206, 230, 1), BlendMode.srcIn),
                                width: 20,
                              ),
                            ),
                            Text('Cerrar Sesión',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: HexColor.fromHex('#000066'),
                                fontSize: 18
                              )
                            )
                          ],
                        )
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}