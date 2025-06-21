import 'package:prestaqi/models/data_advance_capital_notification.model.dart';

class NotificationModel {
  late int id;
  late String icon;
  late String title;
  late String message;
  late bool read;
  late dynamic data;

  NotificationModel({
    this.id = 0,
    this.icon = '',
    this.title = '',
    this.message = '',
    this.read = false,
    this.data
  });

  factory NotificationModel.fromJson(Map<String, dynamic> object) {
    // ignore: prefer_typing_uninitialized_variables
    var data;

    if (object.containsKey("data") && object["data"] != null && object["data"]['Capital_Id'] != null &&  object['data']['Amount'] != null) {
      data = DataAdvanceCapitalNotificationModel(
        amount: object['data']['Amount'] as double,
        capitalId: object['data']['Capital_Id'] as int
      );
    }

    return NotificationModel(
      data: object['data'] == null ? {} : data,
      icon: object['icon'] ?? 'info',
      id: object['id'] as int,
      message: object['message'] ?? '',
      read: false,
      title: object['title'] ?? ''
    );
  }
}