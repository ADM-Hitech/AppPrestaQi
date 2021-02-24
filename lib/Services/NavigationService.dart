import 'package:flutter/material.dart';
import 'package:prestaQi/Modals/AlertSuccessModal.dart';
import 'package:prestaQi/Modals/CartaMandatoInversionistaModal.dart';
import 'package:prestaQi/Modals/CartaMandatoModal.dart';
import 'package:prestaQi/Modals/ConfirmDeleteAccountModal.dart';
import 'package:prestaQi/Modals/ConfirmLogoutModal.dart';
import 'package:prestaQi/Modals/ContractModal.dart';
import 'package:prestaQi/Modals/DetailForPaymentPeriodicModal.dart';
import 'package:prestaQi/Modals/DetailsAdvancePeriodicModal.dart';
import 'package:prestaQi/Modals/ErrorRequestAdvanceModal.dart';
import 'package:prestaQi/Modals/GeneralNoticeModal.dart';
import 'package:prestaQi/Modals/ShowIframeCartaMandatoModal.dart';
import 'package:prestaQi/Modals/ShowIframeModal.dart';
import 'package:prestaQi/Modals/UploadReceipt.dart';
import 'package:prestaQi/Models/Advance.dart';
import 'package:prestaQi/Models/DataAdvanceCapitalNotification.dart';
import 'package:prestaQi/Models/InfoBank.dart';
import 'package:prestaQi/Models/DetailsAdvance.dart' as DetailAdvance;

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> goBack() {
    return navigatorKey.currentState.maybePop((e) => {});
  }

  Future<dynamic> navigateToAndRemoveHistory(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  Future<dynamic> showCartaMandato(BuildContext context, InfoBank infoBank) {
    return Navigator.of(context).push(CartaMandatoModal(infoBank: infoBank));
  }

  Future<dynamic> showIframeCartaMandato(BuildContext context, String url, Advance calculateAdvance) {
    return Navigator.of(context).push(ShowIframeCartaMandatoModal(url: url, calculateAdvance: calculateAdvance));
  }

  Future<dynamic> showGeneralNotice(BuildContext context, String url) {
    return Navigator.of(context).push(GeneralNoticeModal(url: url));
  }

  Future<dynamic> showIframe(BuildContext context, String url, String textAccepted, String textCancel) {
    return Navigator.of(context).push(ShowIframeModal(url: url, textAccepted: textAccepted, textCancel: textCancel));
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

  Future<dynamic> showDetailsAdvancePeriodic(BuildContext context, Advance myAdvanceModel) {
    return Navigator.of(context).push(DetailsAdvancePeriodicModal(myAdvanceModel: myAdvanceModel));
  }

  Future<dynamic> showDetailForPayment(BuildContext context, DetailAdvance.DetailsAdvance detail) {
    return Navigator.of(context).push(DetailForPaymentPeriodicModal(detail: detail));
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