import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/ChangePassword/change_password_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class ChangePassword extends StatefulWidget {

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScreenResponsive screen;
  bool loading = false;
  String message = '';

  String validPassword(String value) {
    if (value.isEmpty) {
      return 'El campo es requerido';
    }

    if (value.length < 6 || value.length > 10) {
      return 'La contraseña no es segura';
    }

    return null;
  }

  String validConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'El campo es requerido';
    }

    if (value.length < 6 || value.length > 10) {
      return 'La contraseña no es segura';
    }

    if (value != this.passwordController.text) {
      return 'La contraseña no es igual';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
  }

  void submit() {
    if (this.formKey.currentState.validate()) {
      setState(() {
        this.loading = true;
      });

      appService<AuthService>().changePassword(this.passwordController.text).then((value) {
        if (value.success) {
          if (value.type == 3) {
            appService<NavigationService>().navigateTo('/request-advance');
          } else if (value.type == 2){
            appService<NavigationService>().navigateTo('/my-investments');
          } else {
            appService<NavigationService>().navigateTo('/');
          }
        } else {
          this.message = 'Error al actualizar';
          setState(() {
            this.loading = false;
          });
        }
      }).catchError((onError) {
        setState(() {
          this.message = 'Error al actualizar';
          this.loading = false;
        });
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#000066'),
      key: this.scaffoldKey,
      body: ChangePasswordContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}