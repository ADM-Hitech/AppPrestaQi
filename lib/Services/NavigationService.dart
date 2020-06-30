import 'package:flutter/material.dart';
import 'package:prestaQi/Modals/AlertSuccessModal.dart';
import 'package:prestaQi/Modals/CartaMandatoModal.dart';
import 'package:prestaQi/Modals/ConfirmDeleteAccountModal.dart';
import 'package:prestaQi/Modals/DetailsAdvancePeriodicModal.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> showCartaMandato(BuildContext context) {
    return Navigator.of(context).push(CartaMandatoModal());
  }

  Future<dynamic> showAlertSuccess(BuildContext context) {
    return Navigator.of(context).push(AlertSuccessModal());
  }

  Future<dynamic> showDetailsAdvancePeriodic(BuildContext context) {
    return Navigator.of(context).push(DetailsAdvancePeriodicModal());
  }

  Future<dynamic> showConfirmDeleteAccount(BuildContext context) {
    return Navigator.of(context).push(ConfirmDeleteAccountModal());
  }
}