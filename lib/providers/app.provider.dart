import 'package:flutter/material.dart';

class AppProvider extends InheritedWidget {

  final int countNotification;
  final Function updateCountNotification;

  const AppProvider({
    super.key,
    required super.child,
    required this.countNotification,
    required this.updateCountNotification
  });

  @override
  bool updateShouldNotify(AppProvider oldWidget) => true;

  static AppProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>();
  }
}