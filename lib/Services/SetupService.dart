import 'package:get_it/get_it.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/DialogService.dart';
import 'package:prestaQi/Services/InvestmentsService.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/RequestAdvance.dart';
import 'package:prestaQi/Services/UserService.dart';
import 'package:prestaQi/app_settings.dart';

GetIt appService = GetIt.instance;

void setupService() {
  appService.registerSingleton(AppSettings());
  appService.registerLazySingleton(() => DialogService());
  appService.registerLazySingleton(() => NavigationService());
  appService.registerLazySingleton(() => AuthService());
  appService.registerLazySingleton(() => RequestAdvanceService());
  appService.registerLazySingleton(() => UserService());
  appService.registerLazySingleton(() => InvestmentsService());
}