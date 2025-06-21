import 'package:flutter/material.dart';
import 'package:prestaqi/pages/notification/page.dart';
import 'package:prestaqi/providers/notification.provider.dart';
import 'package:prestaqi/widgets/item_notification.widget.dart';
import 'package:provider/provider.dart';

Widget notificationBody({
  required NotificationState state
}) {
  var pNotification = Provider.of<NotificationProvider>(state.context);
  pNotification.listAlers.addAll(state.notifications);

  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60)
        )
      ),
      child: state.loading ?
        const Center(
          child: CircularProgressIndicator(),
        )
      :
      ListView.builder(
        key: state.keyNotification,
        padding: const EdgeInsets.only(top: 35, left: 0, right: 0, bottom: 0),
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (cntx, i) {
          return Column(
            children: state.getItemsNoDuplicated(pNotification.listAlers).map((item) => 
              GestureDetector(
                onTap: () {
                  state.openNotification(item);
                },
                child: itemNotification(notification: item, context: state.context),
              )
            ).toList(),
          );
        }
      ),
    );
}