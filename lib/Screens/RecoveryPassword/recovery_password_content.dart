import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/RecoveryPassword/recovery_password.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class RecoveryPasswordContent extends StatelessWidget {

  final RecoveryPasswordState state;

  RecoveryPasswordContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            HexColor.fromHex('#3333ff'),
            HexColor.fromHex('#33ccff'),
            HexColor.fromHex('#33ccff')
          ]
        )
      ),
      child: Form(
        key: this.state.formKey,
        child: ListView(
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
                child: Text('Recuperar contraseña', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Center(
              child: Container(
                width: this.state.screen.width * .8,
                child: Text('Ingresa tus correo electrónico', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21
                  )
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: Container(
                width: this.state.screen.width * .8,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.all(0),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                  )
                )
              ),
            ),
            if (this.state.message.isNotEmpty)
              SizedBox(
                height: 5,
              )
            ,
            if (this.state.message.isNotEmpty)
              Center(
                child: Container(
                  width: this.state.screen.width * .8,
                  margin: EdgeInsets.symmetric(vertical: 25),
                  child: Text(this.state.message, style: TextStyle(color: Colors.white)),
                ),
              )
            ,
            SizedBox(
              height: this.state.message.isNotEmpty ? 5 : 35,
            ),
            Center(
              child: GestureDetector(
                onTap:() {
                  appService<NavigationService>().navigateTo('/auth');
                },
                child: Container(
                  width: this.state.screen.width * .8,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 63,
                      padding: EdgeInsets.only(
                        bottom: 2, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: Colors.white,  // Text colour here
                          width: 1.0, // Underline width
                        ))
                      ),
                      child: Text('Regresar', style: 
                        TextStyle(
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: Container(
                width: this.state.screen.width * .8,
                child: GestureDetector(
                  onTap: this.state.loading ? () {} : this.state.submit,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#000066'),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: this.state.loading ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ENVIAR', 
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          )
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(left: 15),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      ],
                    ) : 
                    Center(
                      child: Text(
                        'ENVIAR', 
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        )
                      ),
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}