import 'package:flutter/material.dart';
import 'package:prestaqi/models/user_token.model.dart';
import 'package:prestaqi/pages/setting_info_app/content.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingInfoAppPage extends StatefulWidget {
  const SettingInfoAppPage({super.key});

  @override
  SettingInfoAppState createState() => SettingInfoAppState();
}

class SettingInfoAppState extends State<SettingInfoAppPage> {
  
  late UserTokenModel user;
  String version = '1.0.0';

  @override
  void initState() {
    super.initState();
    me();
    getPackageInfo();
  }

  Future<void> getPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    setState(() {
      version = info.version;
    });
  }

  void me() {
     appService<AppService>().me().then((value) {
       setState(() {
         user = value;
       });
     }).catchError((onError) {});
  }

  void showTerminos() {
    appService<NavigationService>().showIframe(context, user.urlTerminosCondiciones, null, null);
  }

  void showAvisoPrivacidad() {
    appService<NavigationService>().showIframe(context, user.urlAvisoPrivacidad, null, null);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 244, 255, 1),
      appBar: appBar(context: context, title: 'Información de la app'),
      body: settingInfoAppBody(state: this),
    );
  }
}