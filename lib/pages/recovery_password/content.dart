import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/recovery_password/page.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';

import '../../utils/hexcolor.dart';

Widget recoveryPasswordContent({
  required RecoveryPasswordState state
}) {

  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
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
      key: state.formKey,
      child: ListView(
        children: [
          SvgPicture.asset(
            'assets/icons/ico-logo.svg',
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: width * .8,
          ),
          Center(
            child: SizedBox(
              width: width * .8,
              child: const Text('Recuperar contraseña', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Center(
            child: SizedBox(
              width: width * .8,
              child: const Text('Ingresa tus correo electrónico', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21
                )
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
                controller: state.emailController,
                style: const TextStyle(color: Colors.white),
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
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
          if (state.message.isNotEmpty)
            const SizedBox(
              height: 5,
            )
          ,
          if (state.message.isNotEmpty)
            Center(
              child: Container(
                width: width * .8,
                margin: const EdgeInsets.symmetric(vertical: 25),
                child: Text(state.message, style: const TextStyle(color: Colors.white)),
              ),
            )
          ,
          SizedBox(
            height: state.message.isNotEmpty ? 5 : 35,
          ),
          Center(
            child: GestureDetector(
              onTap:() {
                appService<NavigationService>().navigateTo('auth');
              },
              child: SizedBox(
                width: width * .8,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 63,
                    padding: const EdgeInsets.only(
                      bottom: 2, // space between underline and text
                    ),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Colors.white,  // Text colour here
                        width: 1.0, // Underline width
                      ))
                    ),
                    child: const Text('Regresar', style: 
                      TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),
                ),
              ),
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
                    color: HexColor.fromHex('#000066'),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: state.loading ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
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
                        margin: const EdgeInsets.only(left: 15),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    ],
                  ) : 
                  const Center(
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