import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestaQi/Models/Alert.dart';
import 'package:prestaQi/Models/AppProviderModel.dart';
import 'package:prestaQi/Models/DataAdvanceCapitalNotification.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Services/DialogService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Widgets/DialogManager.dart';
import 'package:prestaQi/Widgets/StartupView.dart';
import 'package:prestaQi/app_provider.dart';
import 'package:prestaQi/providers/NotificationProvider.dart';
import 'package:prestaQi/providers/push_notifications.dart';
import 'package:prestaQi/router.dart';
import 'package:prestaQi/Utils/HexColor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

void main() {
  setupService();

  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) => {});
  
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationProvider>(create: (_) => NotificationProvider())
      ],
      child: App(),
    )
  );
}

class App extends StatefulWidget {

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  UserToken userToken = new UserToken();
  int countNotification = 0;

  @override
  void initState() {
    super.initState();
    //para consultar los argumentos del router 
    //ModalRoute.of(context).settings.arguments;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final pNotification = Provider.of<NotificationProvider>(context, listen: false);
    final pushNotificationProvider = new PushNotificationProvider();

    pushNotificationProvider.initNotifications();

    pushNotificationProvider.messajes.listen((event) {
      //appService<NavigationService>().navigateTo('/auth');
      Alert newAlert;

      if (Platform.isIOS) {

        String message = '';
        String title = '';

        if (event['notification'] != null) {
          message = event['notification']['body'] ?? '';
          title = event['notification']['title'] ?? '';
        }

        if (event['aps'] != null) {
          message = event['aps']['alert']['body'] ?? '';
          title = event['aps']['alert']['title'] ?? '';
        }

        if (event['Capital_Id'] != null) {
          newAlert = new Alert(
            data: new DataAdvanceCapitalNotification(
              amount: double.tryParse(event['Amount']),
              capitalId: int.tryParse(event['Capital_Id']),
              createdAt: DateTime.tryParse(event['created_at'])
            ),
            icon: event['icon'],
            id: int.tryParse(event['notification_id']) ?? Random().nextInt(100),
            message: message,
            title: title
          );
        } else {
          newAlert = new Alert(
            data: {},
            icon: event['icon'],
            id: int.tryParse(event['notification_id']) ?? Random().nextInt(100),
            message: message,
            title: title
          );
        }

        print(newAlert);
      } else {
        if (event['data']['Capital_Id'] != null) {

          newAlert = new Alert(
            data: new DataAdvanceCapitalNotification(
              amount: double.tryParse(event['data']['Amount']),
              capitalId: int.tryParse(event['data']['Capital_Id']),
              createdAt: DateTime.tryParse(event['data']['created_at'])
            ),
            icon: event['data']['icon'],
            id: int.tryParse(event['data']['notification_id']) ?? Random().nextInt(100),
            message: event['notification']['body'] ?? '',
            title: event['notification']['title'] ?? ''
          );

        } else {
          newAlert = new Alert(
            data: {},
            icon: event['data']['icon'],
            id: int.tryParse(event['data']['notification_id']) ?? Random().nextInt(100),
            message: event['notification']['body'] ?? '',
            title: event['notification']['title'] ?? ''
          );
        } 
      }

      pNotification.addAlert(newAlert);

      setState(() {
        this.countNotification++;
        this.updateAppBadger();
      });
    });
  }

  void updateAppBadger() async {
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      if (this.countNotification > 0) {
        FlutterAppBadger.updateBadgeCount(this.countNotification);
      } else {
        FlutterAppBadger.removeBadge();
      }
    }
  }

  void updateCountNotification() {
    final pNotification = Provider.of<NotificationProvider>(context, listen: false);
    setState(() {
      this.countNotification = pNotification.count;
      this.updateAppBadger();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return AppProvider(
      appProvider: AppProviderModel(),
      countNotification: this.countNotification,
      updateCountNotification: this.updateCountNotification,
      child: MaterialApp(
        title: 'PrestaQi',
        theme: ThemeData(
          primaryColor: HexColor.fromHex('#000066'),
          bottomAppBarColor: HexColor.fromHex('#33ccff'),
          fontFamily: 'Montserrat'
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Navigator(
            key: appService<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(child: child)
            ),
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