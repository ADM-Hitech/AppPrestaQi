import 'package:flutter/material.dart';
import 'package:prestaQi/Models/AppProviderModel.dart';

class AppProvider extends InheritedWidget {

  final AppProviderModel appProvider;
  final int countNotification;

  AppProvider({Key key, Widget child, this.appProvider, this.countNotification}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppProvider oldWidget) => true;

  static AppProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }
}