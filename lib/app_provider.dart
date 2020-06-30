import 'package:flutter/material.dart';
import 'package:prestaQi/Models/AppProviderModel.dart';

class AppProvider extends InheritedWidget {

  final AppProviderModel appProvider;

  AppProvider({Key key, Widget child, this.appProvider}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppProvider oldWidget) => true;

  static AppProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }
}