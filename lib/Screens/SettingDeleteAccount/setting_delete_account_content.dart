import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/SettingDeleteAccount/setting_delete_account.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class SettingDeleteAccountContent extends StatelessWidget {

  final SettingDeleteAccountState state;

  SettingDeleteAccountContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60)
        )
      ),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (cntx, i) {
          return Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(239, 244, 255, 1),
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(
                      color: Color.fromRGBO(222, 227, 237, 1),
                      width: 1.5
                    ),
                    boxShadow: [
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
                  width: this.state.screen.width * .8,
                  margin: EdgeInsets.only(top: 60),
                  child: Text(
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
              if (this.state.loading) ...[
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ] else ...[
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Tu cuenta de PrestaQi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    this.state.user.typeName == 'Acreditado' ? 'Tu historia de adelantos.' : 'Tu historia de inversiones.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(142, 145, 162, 1)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
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
                    margin: EdgeInsets.only(top: 30),
                    width: 60,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(222, 227, 237, 1),
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    width: this.state.screen.width * .8,
                    child: GestureDetector(
                      onTap: this.state.deleteMyAccount,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('#000066'),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/icons/ico-borrar.svg',
                                color: Color.fromRGBO(202, 206, 230, 1),
                                width: 23,
                              )
                            ),
                            Center(
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
}