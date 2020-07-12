import 'package:flutter/material.dart';
import 'package:prestaQi/Models/Alert.dart';
import 'package:prestaQi/Screens/Notification/notification_content.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:prestaQi/app_provider.dart';

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
    /*this.notifications.add(new Alert(id: 1, data: {}, icon: 'info', message: 'Tu contraseña se guardó con éxito', title: ''));
    this.notifications.add(new Alert(id: 2, data: {}, icon: 'done', message: 'Tu dinero ha sido depositado', title: ''));*/
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
            onTap: () {
              Navigator.pop(context);
            },
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