import 'package:flutter/material.dart';
import 'package:prestaQi/Models/AppProviderModel.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Services/DialogService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Widgets/DialogManager.dart';
import 'package:prestaQi/Widgets/StartupView.dart';
import 'package:prestaQi/app_provider.dart';
import 'package:prestaQi/router.dart';
import 'package:prestaQi/Utils/HexColor.dart';

void main() {
  setupService();
  
  runApp(App());
}

class App extends StatefulWidget {

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  UserToken userToken = new UserToken();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return AppProvider(
      appProvider: AppProviderModel(),
      child: MaterialApp(
        title: 'PrestaQi',
        theme: ThemeData(
          primaryColor: HexColor.fromHex('#000066'),
          bottomAppBarColor: HexColor.fromHex('#33ccff'),
          fontFamily: 'Montserrat'
        ),
        builder: (context, child) => Navigator(
          key: appService<DialogService>().dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)
          ),
        ),
        navigatorKey: appService<NavigationService>().navigatorKey,
        onGenerateRoute: (settings) => generateRoute(settings, userToken),
        home: StartupView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}