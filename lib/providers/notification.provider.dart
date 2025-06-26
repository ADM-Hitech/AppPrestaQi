import 'package:flutter/material.dart';
import 'package:prestaqi/models/notification.model.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationModel> _alert = [];

  void addAlerts(List<NotificationModel> alerts) {
    _alert.addAll(alerts);

    notifyListeners();
  }

  void addAlert(NotificationModel alert) {
    var alertFind = _alert.firstWhere((element) => element.id == alert.id, orElse: () => NotificationModel());

    if (alertFind.title.isEmpty) {
      _alert.add(alert);
    }

    notifyListeners();
  }

  void deleteAlert(NotificationModel alert) {
    var alertFind = _alert.firstWhere((element) => element.id == alert.id, orElse: () => NotificationModel());

    if (alertFind.title.isEmpty) {
      _alert.removeWhere((element) => element.id == alert.id);
    }

    notifyListeners();
  }

  void clearAlert() {
    _alert.clear();

    notifyListeners();
  }

  List<NotificationModel> get listAlers => _alert;

  int get count => _alert.length;
  int get countNews => _alert.where((element) => !element.read).length;
}