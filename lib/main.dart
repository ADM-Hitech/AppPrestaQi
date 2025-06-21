import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prestaqi/providers/app.provider.dart';
import 'package:prestaqi/providers/notification.provider.dart';
import 'package:prestaqi/providers/push_notification.provider.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/router.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';
import 'package:prestaqi/utils/hexcolor.dart';
import 'package:prestaqi/widgets/startup_view.widget.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Provider.debugCheckInvalidValueType = null;

  final prefs = PreferenceUser();
  await prefs.initPrefs();

  setupServices();

  PushNotificationProvider(mesajesStreamController: appService<AppSettings>().messajesStreamController);

  runApp(MultiProvider(
    providers: [
      Provider<NotificationProvider>(create: (_) => NotificationProvider()),
    ],
    child: const PrestaQiApp(),
  ));
}

class PrestaQiApp extends StatefulWidget {
  const PrestaQiApp({ Key? key }) : super(key: key);

  @override
  PrestaQiAppState createState() => PrestaQiAppState();
}

class PrestaQiAppState extends State<PrestaQiApp> with WidgetsBindingObserver {

  PreferenceUser pref = PreferenceUser();
  int countNotification = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void updateCountNotification() {
    final pNotification = Provider.of<NotificationProvider>(context, listen: false);

    setState(() {
      countNotification = pNotification.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      countNotification: countNotification,
      updateCountNotification: updateCountNotification,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PrestaQi',
        theme: ThemeData(
          primaryColor: HexColor.fromHex('#00AAE5'),
          fontFamily: 'Montserrat',
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color.fromRGBO(40, 168, 177, 1))
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('es')],
        navigatorKey: appService<NavigationService>().navigationKey,
        onGenerateRoute: generateRoute,
        home: const StatupView(),
      ),
    );
  }
}
