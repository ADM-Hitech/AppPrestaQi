import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/RecoveryPassword/recovery_password_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Utils/ValidatorText.dart';

class RecoveryPassword extends StatefulWidget {

  @override
  RecoveryPasswordState createState() => RecoveryPasswordState();
}

class RecoveryPasswordState extends State<RecoveryPassword> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScreenResponsive screen;
  String message = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
  }

  String validEmail(String value) {
    if (value.isEmpty) {
      return 'Ingrese un correo';
    }

    if (ValidatorText.email(value.replaceAll(new RegExp(r"\s+"), ''))) {
      return 'Email no valido';
    }

    return null;
  }

  void submit() async {
    if (this.formKey.currentState.validate()) {
      setState(() {
        this.loading = true;
        this.message = '';
      });

      appService<AuthService>().recoveryPassword(this.emailController.text.replaceAll(new RegExp(r"\s+"), '')).then((value) => {
        setState(() {
          this.message = value;
          this.loading = false;
        })
      }).catchError((onError) {
        setState(() {
          this.message = 'Error al recuperar la contraseña';
          this.loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: this.scaffoldKey,
      body: RecoveryPasswordContent(state: this),
    );
  }
}