import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/Login/login.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class LoginContent extends StatelessWidget {
  
  final LoginState state;

  LoginContent({Key key, @required this.state});

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
        child:ListView(
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
                child: Text('Bienvenido', 
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
                child: Text('Ingresa tus datos para continuar', 
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
                  controller: this.state.emailController,
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
            SizedBox(
              height: 35,
            ),
            Center(
              child: Container(
                width: this.state.screen.width * .8,
                child: TextFormField(
                  controller: this.state.passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Ingrese un password";
                    }
                    
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.none,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.all(0),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                  )
                )
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: Container(
                width: (this.state.screen.width * .8) + 30,
                padding: EdgeInsets.only(right: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: HexColor.fromHex('#000066'),
                            activeColor: Colors.white,
                            onChanged: (bool value) {},
                            value: true,
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {},
                              child: Text('Recordar mis datos', style: TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        appService<NavigationService>().navigateTo('/recovery-password');
                      },
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: SvgPicture.asset(
                                'assets/icons/ico-candado.svg',
                                color: Colors.white,
                                width: 23,
                              ),
                            ),
                            Container(
                              child: Text('Recuperar contraseña', style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (this.state.error.isNotEmpty)
              Center(
                child: Container(
                  width: this.state.screen.width * .8,
                  child: Text(this.state.error, style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              )
            ,
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
                          'INGRESAR', 
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
                        'INGRESAR', 
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
            )
          ],
        )
      ),
    );
  }
} 