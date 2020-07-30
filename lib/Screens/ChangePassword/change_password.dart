import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/ChangePassword/change_password_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/Utils/HexColor.dart';
import 'package:provider/provider.dart';

import '../../Models/Alert.dart';
import '../../app_provider.dart';
import '../../providers/NotificationProvider.dart';

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
  bool rememberUser = false;
  int changePassword = 0;

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
    final pNotification = Provider.of<NotificationProvider>(context, listen: false);

    if (this.formKey.currentState.validate()) {
      setState(() {
        this.loading = true;
      });

      if (this.changePassword == 1) {
        appService<AuthService>().changePassword(this.passwordController.text, this.rememberUser).then((value) async{
          if (value.success) {
            appService<NavigationService>().goBack();
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

        return;
      }

      setState(() {
        this.rememberUser = ModalRoute.of(context).settings.arguments is bool ? ModalRoute.of(context).settings.arguments as bool : false;
      });

      appService<AuthService>().me().then((value) async {
        if (value.type == 3) {
          bool result = await appService<NavigationService>().showIframe(context, value.urlContratoMutuoAccredited, 'Si Acepto', 'No Acepto');
          if (!result) {
            await appService<AuthService>().logout();
            appService<NavigationService>().navigateTo('/auth');
            return;
          }
          
          bool resultAvisoGeneral = await appService<NavigationService>().showIframe(context, value.urlCartaAvisoGeneral, 'Si Acepto', 'No Acepto');
          if (!resultAvisoGeneral) {
            await appService<AuthService>().logout();
            appService<NavigationService>().navigateTo('/auth');
            return;
          }

          bool resultTransferDataPerson = await appService<NavigationService>().showIframe(context, value.urlTransferDataPersonal, 'Si Acepto', 'No Acepto');
          if (!resultTransferDataPerson) {
            await appService<AuthService>().logout();
            appService<NavigationService>().navigateTo('/auth');
            return;
          }
        }

        appService<AuthService>().changePassword(this.passwordController.text, this.rememberUser).then((value) async{
          if (value.success) {
            
            pNotification.addAlert(new Alert(
              data: null,
              icon: 'info',
              id: -1,
              message: 'Gracias por crear tu cuenta con nosotros.',
              title: 'Bienvenido a PrestaQi'
            ));

            AppProvider.of(context).updateCountNotification();

            if (value.type == 3) {
              appService<NavigationService>().navigateTo('/request-advance');
            } else if (value.type == 2){
              appService<NavigationService>().navigateTo('/my-investments');
            } else {
              appService<NavigationService>().navigateTo('/auth');
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

      }).catchError((onError) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      this.changePassword = ModalRoute.of(context).settings.arguments is int ? ModalRoute.of(context).settings.arguments as int : 0;
    });

    return Scaffold(
      backgroundColor: HexColor.fromHex('#000066'),
      key: this.scaffoldKey,
      body: ChangePasswordContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}