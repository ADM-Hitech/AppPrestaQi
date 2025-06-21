import 'package:flutter/material.dart';
import 'package:prestaqi/modals/alert_success.modal.dart';
import 'package:prestaqi/modals/carta_mandato_inversionista.modal.dart';
import 'package:prestaqi/modals/confirm_logout.modal.dart';
import 'package:prestaqi/modals/detail_for_payment_periodic.modal.dart';
import 'package:prestaqi/modals/details_advance_periodic.modal.dart';
import 'package:prestaqi/modals/error_request_advance.modal.dart';
import 'package:prestaqi/modals/show_iframe.modal.dart';
import 'package:prestaqi/modals/show_iframe_carta_mandato.modal.dart';
import 'package:prestaqi/modals/upload_receipt.modal.dart';
import 'package:prestaqi/models/advance.model.dart';
import 'package:prestaqi/models/data_advance_capital_notification.model.dart';
import 'package:prestaqi/models/details_advance.model.dart';

import '../modals/confirm_delete_account.modal.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, { Object? arguments }) {
    return navigationKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> goBack({ Object? arguments }) {
    return navigationKey.currentState!.maybePop(arguments);
  }

  Future<dynamic> navigateToAndRemoveHistory(String routerName, { Object? arguments }) {
    return navigationKey.currentState!.pushNamedAndRemoveUntil(routerName, (route) => false, arguments: arguments);
  }

  Future<dynamic> showIframe(BuildContext context, String url, String? textAccepted, String? textCancel) {
    return Navigator.of(context).push(ShowIframeModal(url: url, textAccepted: textAccepted, textCancel: textCancel));
  }

  Future<dynamic> showConfirmDeleteAccount(BuildContext context) {
    return Navigator.of(context).push(ConfirmDeleteAccountModal());
  }

  Future<dynamic> showCartaMandatoInversionista(BuildContext context, DataAdvanceCapitalNotificationModel info) {
    return Navigator.of(context).push(CartaMandatoInversionistaModal(info: info));
  }

  Future<dynamic> showUploadFile(BuildContext context, DataAdvanceCapitalNotificationModel info) {
    return Navigator.of(context).push(UploadReceiptModal(info: info));
  }

  Future<dynamic> showIframeCartaMandato(BuildContext context, String url, AdvanceModel calculateAdvance) {
    return Navigator.of(context).push(ShowIframeCartaMandatoModal(url: url, calculateAdvance: calculateAdvance));
  }

  Future<dynamic> showAlertSuccess(BuildContext context) {
    return Navigator.of(context).push(AlertSuccessModal());
  }

  Future<dynamic> showErrorRequestAdvance(BuildContext context) {
    return Navigator.of(context).push(ErrorRequestAdvanceModal());
  }

  Future<dynamic> showConfirmLogout(BuildContext context) {
    return Navigator.of(context).push(ConfirmLogoutModal());
  }

  Future<dynamic> showDetailForPayment(BuildContext context, DetailsAdvanceModel detail) {
    return Navigator.of(context).push(DetailForPaymentPeriodicModal(detail: detail));
  }

  Future<dynamic> showDetailsAdvancePeriodic(BuildContext context, AdvanceModel myAdvanceModel) {
    return Navigator.of(context).push(DetailsAdvancePeriodicModal(myAdvanceModel: myAdvanceModel));
  }
}