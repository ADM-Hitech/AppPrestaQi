import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/login/page.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/widgets/button.widget.dart';
import 'package:prestaqi/widgets/checkbox.widget.dart';
import 'package:prestaqi/widgets/input.widget.dart';
import 'package:prestaqi/services/navigation.service.dart';

import '../../utils/hexcolor.dart';

Widget loginBody({
  required LoginState state
}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
    width: width,
    height: height,
    padding: const EdgeInsets.symmetric(horizontal: 36),
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
    child: ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height > 890 ? 250 : 150,
              width: width,
              child: Stack(
                children: [
                  Positioned(
                    top: -75,
                    right: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      'assets/icons/ico-logo.svg',
                      color: Colors.white,
                      width: width * .8,
                    ),
                  )
                ],
              ),
            ),
            const Center(
              child: Text('Bienvenido', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                ),
            ),
            const SizedBox(
              height: 3,
            ),
            Center(
              child: SizedBox(
                width: width * .8,
                child: const Text('Ingresa tus datos para continuar', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21
                  )
                ),
              ),
            ),
            const SizedBox(height: 36),
            inputWidget(
              context: state.context,
              stream: state.bloc.emailStream,
              onChange: state.bloc.changeEmail,
              controller: state.bloc.emailController,
              label: 'Correo electrónico',
              borderColor: true,
              filled: false,
              inputType: TextInputType.emailAddress,
              colorFill: Colors.transparent,
              colorLabel: Colors.white,
              colorBorder: Colors.white,
              textCapitalization: TextCapitalization.none
            ),
            const SizedBox(height: 24),
            inputWidget(
              context: state.context,
              stream: state.bloc.passwordStream,
              onChange: state.bloc.changePassword,
              controller: state.bloc.passwordController,
              label: 'Contraseña',
              borderColor: true,
              filled: false,
              inputType: TextInputType.emailAddress,
              colorFill: Colors.transparent,
              colorLabel: Colors.white,
              colorBorder: Colors.white,
              textCapitalization: TextCapitalization.none,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  checkboxWidget(
                    context: state.context,
                    label: const Text('Recordar mis datos', style: TextStyle(color: Colors.white),),
                    stream: state.bloc.reminMeStream,
                    onChange: state.bloc.changeRemindMe,
                    activeColor: Colors.white,
                    checkColor: Colors.blue
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => appService<NavigationService>().navigateTo('recovery'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: SvgPicture.asset('assets/icons/ico-candado.svg', color: Colors.white)
                        ),
                        const SizedBox(width: 15),
                        const Text('Recuperar contraseña', style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            StreamBuilder(
              stream: state.bloc.formValidStream,
              builder: (BuildContext ctx, AsyncSnapshot snp) {
                return Opacity(
                  opacity: snp.hasData && snp.data ? 1 : .3,
                  child: buttonWidget(
                    context: state.context,
                    stream: state.bloc.loadingStream,
                    label: 'INGRESAR',
                    filled: true,
                    bgColor: HexColor.fromHex('#000066'),
                    txtColor: Colors.white,
                    onPress: snp.hasData && snp.data ? state.submit : null
                  ),
                );
              },
            )
          ],
        )
      ],
    )
  );
}