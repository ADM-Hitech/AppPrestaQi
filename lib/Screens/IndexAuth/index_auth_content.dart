import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/IndexAuth/index_auth.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';

import '../../Utils/HexColor.dart';

class IndexAuthContent extends StatelessWidget {

  final IndexAuthState state;

  IndexAuthContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      decoration: BoxDecoration(
        color: HexColor.fromHex('#1292ff'),
        image: DecorationImage(
          image: AssetImage('assets/images/background_auth.png'),
          fit: BoxFit.cover
        )
      ),
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/icons/ico-logo.svg',
                  color: Colors.white,
                  width: this.state.screen.width * .8,
                ),
              ),
              Center(
                child: Container(
                  width: this.state.screen.width * .8,
                  child: Text('El dinero\r\nque necesitas', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55
                    )
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: this.state.screen.width * .8,
                  child: Text('al alcance\r\nde tu mano', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
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
              child: Container(
                width: this.state.screen.width * .8,
                child: GestureDetector(
                  onTap: () {
                    appService<NavigationService>().navigateTo('/request-advance');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#000066'),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: Center(
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
}