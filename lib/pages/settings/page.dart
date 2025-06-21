import 'package:flutter/material.dart';
import 'package:prestaqi/pages/settings/content.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:prestaqi/widgets/drawer_menu.widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }): super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {

  double getFontSize(double width) {
    if (width > 375) {
      return 20;
    } else {
      return 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context: context),
      drawer: const DrawerMenu(),
      body: settingsBody(state: this),
    );
  }
}