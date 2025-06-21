import 'package:flutter/material.dart';
import 'package:prestaqi/pages/recovery_password/content.dart';
import 'package:prestaqi/pages/recovery_password/service.dart';
import 'package:prestaqi/utils/validator_text.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({super.key});

  @override
  RecoveryPasswordState createState() => RecoveryPasswordState();
}

class RecoveryPasswordState extends State<RecoveryPasswordPage> {

  RecoveryPasswordService service = RecoveryPasswordService();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String message = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  String? validEmail(String value) {
    if (value.isEmpty) {
      return 'Ingrese un correo';
    }

    if (ValidatorText.email(value.replaceAll(RegExp(r"\s+"), ''))) {
      return 'Email no valido';
    }

    return null;
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        message = '';
      });

      var email = emailController.text.replaceAll(RegExp(r"\s+"), '');

      service.recoveryPassword(email).then((value) => {
        setState(() {
          message = value;
          loading = false;
        })
      }).catchError((onError) => {
        setState(() {
          message = 'Error al recuperar la contraseña';
          loading = false;
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: recoveryPasswordContent(state: this),
    );
  }
}