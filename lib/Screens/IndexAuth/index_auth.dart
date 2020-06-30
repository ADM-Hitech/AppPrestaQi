import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/IndexAuth/index_auth_content.dart';

import '../../Utils/ScreenResponsive.dart';

class IndexAuth extends StatefulWidget {

  @override 
  IndexAuthState createState() => IndexAuthState();
}

class IndexAuthState extends State<IndexAuth> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      key: this.scaffoldKey,
      body: IndexAuthContent(state: this),
      extendBodyBehindAppBar: true,
    );
  }
}