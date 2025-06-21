import 'package:get_it/get_it.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/notification.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';
import 'package:prestaqi/utils/geolocation.dart';

GetIt appService = GetIt.instance;

void setupServices() {
  appService.registerLazySingleton(() => AppSettings());
  appService.registerLazySingleton(() => NavigationService());
  appService.registerLazySingleton(() => AppService());
  appService.registerLazySingleton(() => NotificationService());
  appService.registerLazySingleton(() => Geolocation());
}