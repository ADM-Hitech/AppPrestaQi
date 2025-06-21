import 'package:flutter/material.dart';
import 'package:prestaqi/pages/change_password/page.dart';
import 'package:prestaqi/utils/hexcolor.dart';

Widget changePasswordBody({
  required ChangePasswordState state
}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
    height: height,
    width: width,
    color: HexColor.fromHex('#000066'),
    child: ListView(
      children: [
        SizedBox(
          height: height + 40,
          width: width,
          child: Form(
            key: state.formKey,
            child: Column(
              children: [
                Center(
                  child: Image.asset('assets/icons/change_password_icon.png', width: 80),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: Text('Cambiar contraseña', 
                    style: TextStyle(
                      color: HexColor.fromHex('#3333ff'),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 26
                    )
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: SizedBox(
                    width: width * .8,
                    child: const Text(
                      'Ingresa tu nueva contraseña a continuación, es para protección de tu cuenta.', 
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: SizedBox(
                    width: width * .8,
                    child: const Text(
                      'La contraseña debe tener entre 6 y 10 caracteres y puede incluir letras (mayúsculas o minúsculas), números del 0 al 9 y signos de puntuación.', 
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: SizedBox(
                    width: width * .8,
                    child: TextFormField(
                      controller: state.passwordController,
                      style: const TextStyle(color: Colors.white),
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                      ),
                      obscureText: true,
                      validator: state.validPassword,
                    )
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: SizedBox(
                    width: width * .8,
                    child: TextFormField(
                      controller: state.confirmPasswordController,
                      style: const TextStyle(color: Colors.white),
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        labelText: 'Confirme contraseña',
                        labelStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                      ),
                      obscureText: true,
                      validator: state.validConfirmPassword,
                    )
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: SizedBox(
                    width: width * .8,
                    child: GestureDetector(
                      onTap: state.loading ? () {} : state.submit,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('#3333ff'),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: state.loading ? 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
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
                                margin: const EdgeInsets.only(left: 15),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            ],
                          )
                        :
                        const Center(
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