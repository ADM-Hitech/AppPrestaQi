import 'package:flutter/material.dart';
import 'package:prestaqi/pages/technical_support/content.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:prestaqi/widgets/drawer_menu.widget.dart';

class TechnicalSupportPage extends StatefulWidget {
  const TechnicalSupportPage({ super.key });

  @override
  TechnicalSupportState createState() => TechnicalSupportState();
}

class TechnicalSupportState extends State<TechnicalSupportPage> {

  double getFontSize(double width) {
    if (width > 375) {
      return 18;
    } else {
      return 15;
    }
  }

  double getFontSizeData(double width) {
    if (width > 375) {
      return 19;
    } else {
      return 17;
    }
  }

  double getSizeCircleIcon(double width) {
    if (width > 375) {
      return 50;
    } else {
      return 40;
    }
  }

  double getSizeIcon(double width) {
    if (width > 375) {
      return 25;
    } else {
      return 20;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context: context),
      drawer: const DrawerMenu(),
      body: technicalSupportBody(state: this),
    );
  }
}