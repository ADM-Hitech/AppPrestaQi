import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/index_auth/page.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/hexcolor.dart';

import '../../services/navigation.service.dart';

Widget indexAuthBody({
  required IndexAuthState state
}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: HexColor.fromHex('#1292ff'),
      image: const DecorationImage(
        image: AssetImage('assets/images/background_auth.png'),
        fit: BoxFit.cover
      )
    ),
    child: Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 200,
              width: width,
              child: Stack(
                children: [
                  Positioned(
                    top: -75,
                    right: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      'assets/icons/ico-logo.svg',
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: width * .8,
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: width * .8,
                child: Text('El dinero\r\nque necesitas', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: state.getFontSize()
                  )
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: width * .8,
                child: Text('al alcance\r\nde tu mano', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: state.getFontSize(),
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            )
          ],
        ),
        Positioned(
          bottom: 50,
          right: 0,
          left: 0,
          child: Center(
            child: SizedBox(
              width: width * .8,
              child: GestureDetector(
                onTap: () {
                  appService<NavigationService>().navigateTo('auth');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#000066'),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: const Center(
                    child: Text(
                      'INICIAR SESIÓN', 
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      )
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}