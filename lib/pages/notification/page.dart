import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestaqi/models/data_advance_capital_notification.model.dart';
import 'package:prestaqi/models/notification.model.dart';
import 'package:prestaqi/pages/notification/content.dart';
import 'package:prestaqi/providers/app.provider.dart';
import 'package:prestaqi/providers/notification.provider.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/notification.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<NotificationPage> {

  ValueKey<DateTime> keyNotification = ValueKey<DateTime>(DateTime.now());
  List<NotificationModel> notifications = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  void openNotification(NotificationModel alert) async {
    if (alert.data is DataAdvanceCapitalNotificationModel) {
      bool aceptContract = await appService<NavigationService>().showCartaMandatoInversionista(context, alert.data) ?? false;

      if (aceptContract) {
        bool uploaded = await appService<NavigationService>().showUploadFile(context, alert.data) ?? false;
        if (uploaded) {
          appService<NotificationService>().disabledNotifications([alert.id]).then((value) {
            Provider.of<NotificationProvider>(context, listen: false).deleteAlert(alert);
            AppProvider.of(context)!.updateCountNotification();

            setState(() {
              notifications = notifications.where((element) => element.id != alert.id).toList();
            });
          }).catchError((onError) {
            print(onError);
          });
        }
      }
    }
  }

  void deleteNotification() {
    List<int> deleteAlert = [];

    try {
      var pNotification = Provider.of<NotificationProvider>(context, listen: false);
      var fnotification = [...pNotification.listAlers.where((element) => element.data is! DataAdvanceCapitalNotificationModel)];

      for (var element in fnotification) {
        pNotification.deleteAlert(element);
        deleteAlert.add(element.id);
      }

      appService<NotificationService>().disabledNotifications(deleteAlert).then((value) => null).catchError((onError) {});

      AppProvider.of(context)?.updateCountNotification();
    } on PlatformException {}
    
    goBack();
  }

  void goBack() async {
    Navigator.of(context).maybePop((e) => {});
  }

  void getNotifications() async {
    setState(() {
      loading = true;
    });

    appService<NotificationService>().getNotification().then((value) {
      setState(() {
        notifications = value;
        keyNotification = ValueKey<DateTime>(DateTime.now());
        loading = false;
      });
    }).catchError((onError) {
      loading = false;
    });
  }

  List<NotificationModel> getItemsNoDuplicated(List<NotificationModel> alerts) {
    List<NotificationModel> response = [];

    for (var element in alerts) {
      if (response.firstWhere((item) => item.id == element.id, orElse: () => NotificationModel()).id == 0) {
        response.add(element);
      }
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 101, 255, 1),
      appBar: appBar(context: context, title: 'Notificaciones', bgColor: const Color.fromRGBO(40, 101, 255, 1), textColor: Colors.white),
      body: notificationBody(state: this),
    );
  }
}