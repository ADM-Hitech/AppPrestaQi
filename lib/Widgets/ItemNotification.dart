import 'package:flutter/material.dart';
import 'package:prestaQi/Models/Alert.dart';
import 'package:prestaQi/Utils/HexColor.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';

class ItemNotification extends StatelessWidget {
  
  final Alert notification;
  final ScreenResponsive screen;

  ItemNotification({ Key key, @required this.notification, @required this.screen }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(222, 227, 237, 1))
        )
      ),
      child: Row(
        children: [
          if (this.notification.icon == 'done') ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#2865ff'),
                borderRadius: BorderRadius.circular(25)
              ),
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.check, color: Colors.white),
            )
          ] else if (this.notification.icon == 'warning') ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(25)
              ),
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.warning, color: Colors.white),
            )
          ] else if (this.notification.icon == 'error') ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(25)
              ),
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.error_outline, color: Colors.white),
            )
          ] else ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#2865ff'),
                borderRadius: BorderRadius.circular(25)
              ),
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.notifications, color: Colors.white),
            )
          ],
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: this.screen.width - 130,
                  child: Text(
                    this.notification.title,
                    style: TextStyle(
                      color: Color.fromRGBO(77, 77, 77, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    maxLines: 50,
                  ),
                ),
                Container(
                  child: Text(
                    this.notification.message,
                    style: TextStyle(
                      color: Color.fromRGBO(142, 145, 162, 1),
                      fontSize: 15
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}