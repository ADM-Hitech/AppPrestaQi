import 'package:connectivity/connectivity.dart';
import 'package:prestaQi/Models/UserToken.dart';

class AppProviderModel {
  
  bool onLine = true;
  ConnectivityResult typeConnection = ConnectivityResult.none;
  UserToken user = new UserToken();
}