import 'package:flutter/foundation.dart';
import 'package:prestaQi/Models/Alert.dart';

class NotificationProvider with ChangeNotifier {
  List<Alert> _alerts = new List<Alert>();

  void addAlerts(List<Alert> alerts) {
    this._alerts.addAll(alerts);

    notifyListeners();
  }

  void addAlert(Alert alert) {
    var alertFind = this._alerts.firstWhere((element) => element.id == alert.id, orElse: () => null);

    if (alertFind == null) {
      this._alerts.add(alert);
    }

    notifyListeners();
  }

  void deleteAlert(Alert alert) {
    var alertFind = this._alerts.firstWhere((element) => element.id == alert.id, orElse: () => null);

    if (alertFind != null) {
      this._alerts.removeWhere((element) => element.id == alert.id);
    }

    notifyListeners();
  }

  List<Alert> get listAlerts => this._alerts;

  get count => this._alerts.length;
}