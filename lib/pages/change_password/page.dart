import 'package:flutter/material.dart';
import 'package:prestaqi/models/notification.model.dart';
import 'package:prestaqi/pages/change_password/content.dart';
import 'package:prestaqi/providers/notification.provider.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:provider/provider.dart';

import '../../providers/app.provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ChangePasswordState createState() => ChangePasswordState();

}

class ChangePasswordState extends State<ChangePasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool loading = false;
  String message = '';
  bool rememberUser = false;
  int changePassword = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  String? validPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo es requerido';
    }

    if (value.length < 6 || value.length > 10) {
      return 'La contraseña no es segura';
    }

    return null;
  }

  String? validConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo es requerido';
    }

    if (value.length < 6 || value.length > 10) {
      return 'La contraseña no es segura';
    }

    if (value != passwordController.text) {
      return 'La contraseña no es igual';
    }

    return null;
  }

  void init() async {
    await appService<AppService>().isFirstLogin().catchError((onError) {});
  }

  void submit() {
    final pNotification = Provider.of<NotificationProvider>(context, listen: false);

    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      if (changePassword == 1) {
        appService<AppService>().changePassword(passwordController.text, rememberUser).then((value) async{
          if (value.success) {
            appService<NavigationService>().goBack();
          } else {
            message = 'Error al actualizar';
            loading = false;
            setState(() {});
          }
        }).catchError((onError) {
          setState(() {
            message = 'Error al actualizar';
            loading = false;
          });
        });

        return;
      }

      setState(() {
        rememberUser = ModalRoute.of(context)!.settings.arguments is bool ? ModalRoute.of(context)!.settings.arguments as bool : false;
      });

      appService<AppService>().me().then((value) async {
        if (value.type == 3) {
          bool result = await appService<NavigationService>().showIframe(context, value.urlContratoMutuoAccredited, 'Si Acepto', 'No Acepto') ?? false;
          if (!result) {
            appService<AppService>().logout();
            appService<NavigationService>().navigateTo('auth');
            return;
          }
          
          bool resultAvisoGeneral = await appService<NavigationService>().showIframe(context, value.urlCartaAvisoGeneral, 'Si Acepto', 'No Acepto') ?? false;
          if (!resultAvisoGeneral) {
            appService<AppService>().logout();
            appService<NavigationService>().navigateTo('auth');
            return;
          }

          bool resultTransferDataPerson = await appService<NavigationService>().showIframe(context, value.urlTransferDataPersonal, 'Si Acepto', 'No Acepto') ?? false;
          if (!resultTransferDataPerson) {
            appService<AppService>().logout();
            appService<NavigationService>().navigateTo('auth');
            return;
          }
        }

        appService<AppService>().changePassword(passwordController.text, rememberUser).then((value) async{
          if (value.success) {
            
            pNotification.addAlert(NotificationModel(
              data: null,
              icon: 'info',
              id: -1,
              message: 'Gracias por crear tu cuenta con nosotros.',
              title: 'Bienvenido a PrestaQi'
            ));

            AppProvider.of(context)?.updateCountNotification();

            if (value.type == 3) {
              appService<NavigationService>().navigateTo('request-advance');
            } else if (value.type == 2){
              appService<NavigationService>().navigateTo('my-investments');
            } else {
              appService<NavigationService>().navigateTo('auth');
            }

          } else {
            message = 'Error al actualizar';
            loading = false;
            setState(() {});
          }
        }).catchError((onError) {
          setState(() {
            message = 'Error al actualizar';
            loading = false;
          });
        });

      }).catchError((onError) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      changePassword = ModalRoute.of(context)!.settings.arguments is int ? ModalRoute.of(context)!.settings.arguments as int : 0;
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 25),
            width: 45,
            height: 45,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (changePassword == 1) {
                  appService<NavigationService>().goBack();
                } else {
                  appService<NavigationService>().navigateTo('auth');
                }
              },
              child: const Icon(Icons.close, color: Colors.white, size: 45),
            ),
          )
        ],
      ),
      body: changePasswordBody(state: this),
    );
  }
}