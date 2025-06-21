import 'package:flutter/material.dart';
import 'package:prestaqi/pages/settings_security/content.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';

class SettingSecurityPage extends StatefulWidget {
  const SettingSecurityPage({ Key? key }): super(key: key);

  @override
  SettingSecurityState createState() => SettingSecurityState();
}

class SettingSecurityState extends State<SettingSecurityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 244, 255, 1),
      appBar: appBar(context: context, title: 'Seguridad'),
      body: settingsSecurityBody(state: this),
    );
  }
}