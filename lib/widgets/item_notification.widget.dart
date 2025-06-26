import 'package:flutter/material.dart';
import 'package:prestaqi/models/notification.model.dart';
import 'package:prestaqi/utils/hexcolor.dart';

Widget itemNotification({
  required BuildContext context,
  required NotificationModel notification
}) {
  double width = MediaQuery.of(context).size.width;

  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(222, 227, 237, 1))
        )
      ),
      child: Row(
        children: [
          if (notification.icon == 'done') ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#2865ff'),
                borderRadius: BorderRadius.circular(25)
              ),
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.check, color: Colors.white),
            )
          ] else if (notification.icon == 'warning') ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(25)
              ),
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.warning, color: Colors.white),
            )
          ] else if (notification.icon == 'error') ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(25)
              ),
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.error_outline, color: Colors.white),
            )
          ] else ...[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#2865ff'),
                borderRadius: BorderRadius.circular(25)
              ),
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.notifications, color: Colors.white),
            )
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width - 130,
                child: Text(
                  notification.title,
                  style: const TextStyle(
                    color: Color.fromRGBO(77, 77, 77, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  maxLines: 50,
                ),
              ),
              SizedBox(
                width: width - 130,
                child: Text(
                  notification.message,
                  style: const TextStyle(
                    color: Color.fromRGBO(142, 145, 162, 1),
                    fontSize: 15
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
}