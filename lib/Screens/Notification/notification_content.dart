import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/Notification/notification.dart';
import 'package:prestaQi/Widgets/ItemNotification.dart';
import 'package:prestaQi/providers/NotificationProvider.dart';
import 'package:provider/provider.dart';

class NotificationContent extends StatelessWidget {

  final NotificationState state;

  NotificationContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {

    var pNotification = Provider.of<NotificationProvider>(context);
    pNotification.listAlerts.addAll(this.state.notifications);
    
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60)
        )
      ),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 35, left: 0, right: 0, bottom: 0),
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (cntx, i) {
          return Column(
            children: this.state.getItemsNoDuplicated(pNotification.listAlerts).map((item) => 
              GestureDetector(
                onTap: () {
                  this.state.openNotification(item);
                },
                child: ItemNotification(notification: item, screen: this.state.screen),
              )
            ).toList(),
          );
        }
      ),
    );
  }
}