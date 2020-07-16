import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestaQi/Models/Alert.dart';
import 'package:prestaQi/Models/DataAdvanceCapitalNotification.dart';
import 'package:prestaQi/Screens/Notification/notification_content.dart';
import 'package:prestaQi/Services/NavigationService.dart';
import 'package:prestaQi/Services/NotificationService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/app_provider.dart';
import 'package:prestaQi/providers/NotificationProvider.dart';
import 'package:provider/provider.dart';

import '../../Models/Alert.dart';

class Notification extends StatefulWidget {

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  List<Alert> notifications = new List<Alert>();

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.getNotifications();
  }

  void openNotification(Alert alert) async {
    if (alert.data is DataAdvanceCapitalNotification) {
      bool aceptContract = await appService<NavigationService>().showCartaMandatoInversionista(context, alert.data);

      if (aceptContract) {
        bool uploaded = await appService<NavigationService>().showUploadFile(context, alert.data);
        if (uploaded) {
          appService<NotificationService>().disabledNotification(alert.id).then((value) {
            Provider.of<NotificationProvider>(context, listen: false).deleteAlert(alert);
            AppProvider.of(context).updateCountNotification();
          }).catchError((onError) {
            print(onError);
          });
        }
      }
    }
  }

  void deleteNotification() {
    List<int> deleteAlert = new List<int>();

    try {
      var pNotification = Provider.of<NotificationProvider>(context, listen: false);
      var fnotification = [...pNotification.listAlerts.where((element) => !(element.data is DataAdvanceCapitalNotification))];

      fnotification.forEach((element) {
        pNotification.deleteAlert(element);
        deleteAlert.add(element.id);
      });

      appService<NotificationService>().disabledNotifications(deleteAlert).then((value) => null).catchError((onError) {});

      AppProvider.of(context).updateCountNotification();
    } on PlatformException {}
    
    this.goBack();
  }

  void goBack() async {
    Navigator.of(context).maybePop((e) => {});
    //Navigator.pop(context);
  }

  void getNotifications() async {
    appService<NotificationService>().getNotification().then((value) {
      setState(() {
        this.notifications = value;
      });
    }).catchError((onError) {});
  }

  List<Alert> getItemsNoDuplicated(List<Alert> alerts) {
    List<Alert> response = new List<Alert>();

    alerts.forEach((element) {
      if (response.firstWhere((item) => item.id == element.id, orElse: () => null) == null) {
        response.add(element);
      }
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    var count = AppProvider.of(context).countNotification;
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 101, 255, 1),
      key: this.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 101, 255, 1),
        elevation: 0.0,
        centerTitle: true,
        leading: Align(
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 20),
            ),
          ),
        ),
        title: Container(
          child: Text('Notificaciones', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        actions: [
          GestureDetector(
            onTap: this.deleteNotification,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.only(right: 25),
              child: Icon(Icons.close, size: 40),
            ),
          )
        ],
      ),
      body: NotificationContent(state: this),
    );
  }
}