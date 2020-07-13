import 'package:flutter/material.dart';
import 'package:prestaQi/Modals/AlertSuccessModal.dart';
import 'package:prestaQi/Modals/CartaMandatoInversionistaModal.dart';
import 'package:prestaQi/Modals/CartaMandatoModal.dart';
import 'package:prestaQi/Modals/ConfirmDeleteAccountModal.dart';
import 'package:prestaQi/Modals/ConfirmLogoutModal.dart';
import 'package:prestaQi/Modals/ContractModal.dart';
import 'package:prestaQi/Modals/DetailsAdvancePeriodicModal.dart';
import 'package:prestaQi/Modals/ErrorRequestAdvanceModal.dart';
import 'package:prestaQi/Modals/UploadReceipt.dart';
import 'package:prestaQi/Models/DataAdvanceCapitalNotification.dart';
import 'package:prestaQi/Models/InfoBank.dart';
import 'package:prestaQi/Models/MyAdvanceModel.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> showCartaMandato(BuildContext context, InfoBank infoBank) {
    return Navigator.of(context).push(CartaMandatoModal(infoBank: infoBank));
  }

  Future<dynamic> showCartaMandatoInversionista(BuildContext context, DataAdvanceCapitalNotification info) {
    return Navigator.of(context).push(CartaMandatoInversionistaModal(info: info));
  }

  Future<dynamic> showUploadFile(BuildContext context, DataAdvanceCapitalNotification info) {
    return Navigator.of(context).push(UploadReceiptModal(info: info));
  }

  Future<dynamic> showAlertSuccess(BuildContext context) {
    return Navigator.of(context).push(AlertSuccessModal());
  }

  Future<dynamic> showErrorRequestAdvance(BuildContext context) {
    return Navigator.of(context).push(ErrorRequestAdvanceModal());
  }

  Future<dynamic> showDetailsAdvancePeriodic(BuildContext context, MyAdvanceModel myAdvanceModel) {
    return Navigator.of(context).push(DetailsAdvancePeriodicModal(myAdvanceModel: myAdvanceModel));
  }

  Future<dynamic> showConfirmDeleteAccount(BuildContext context) {
    return Navigator.of(context).push(ConfirmDeleteAccountModal());
  }

  Future<dynamic> showConfirmLogout(BuildContext context) {
    return Navigator.of(context).push(ConfirmLogoutModal());
  }

  Future<dynamic> showContract(BuildContext context, String htmlContent) {
    return Navigator.of(context).push(ContractModal(htmlContent: htmlContent));
  }
}