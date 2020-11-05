import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/ChangePassword/change_password.dart';
import '../../Utils/HexColor.dart';

class ChangePasswordContent extends StatelessWidget {

  final ChangePasswordState state;

  ChangePasswordContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      color: HexColor.fromHex('#000066'),
      child: ListView(
        children: [
          Container(
            height: this.state.screen.height,
            width: this.state.screen.width,
            child: Form(
              key: this.state.formKey,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: Image.asset('assets/icons/change_password_icon.png', width: 80),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: Container(
                      child: Text('Cambiar contraseña', 
                        style: TextStyle(
                          color: HexColor.fromHex('#3333ff'),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 26
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
                      child: Text(
                        'Ingresa tu nueva contraseña a continuación, es para protección de tu cuenta.', 
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: Container(
                      width: this.state.screen.width * .8,
                      child: Text(
                        'La contraseña debe tener entre 6 y 10 caracteres y puede incluir letras (mayúsculas o minúsculas), números del 0 al 9 y signos de puntuación.', 
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
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
                        controller: this.state.passwordController,
                        style: TextStyle(color: Colors.white),
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(0),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                        ),
                        obscureText: true,
                        validator: this.state.validPassword,
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
                        controller: this.state.confirmPasswordController,
                        style: TextStyle(color: Colors.white),
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          labelText: 'Confirme contraseña',
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(0),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                        ),
                        obscureText: true,
                        validator: this.state.validConfirmPassword,
                      )
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
                            color: HexColor.fromHex('#3333ff'),
                            borderRadius: BorderRadius.circular(40)
                          ),
                          child: this.state.loading ? 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'GUARDAR CONTRASEÑA', 
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
                            )
                          :
                          Center(
                            child: Text(
                              'GUARDAR CONTRASEÑA', 
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
              ),
            ),
          )
        ],
      ),
    );
  }
}