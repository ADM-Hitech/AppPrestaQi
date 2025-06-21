import 'package:flutter/material.dart';

class AppProvider extends InheritedWidget {

  final int countNotification;
  final Function updateCountNotification;

  const AppProvider({
    Key? key,
    required Widget child,
    required this.countNotification,
    required this.updateCountNotification
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppProvider oldWidget) => true;

  static AppProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }
}