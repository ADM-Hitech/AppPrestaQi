import 'package:prestaqi/models/data_advance_capital_notification.model.dart';

class Alert {
  late int id;
  late String icon;
  late String title;
  late String message;
  dynamic data;

  Alert({
    this.id = 0,
    this.icon = '',
    this.title = '',
    this.message = '',
    this.data
  });

  factory Alert.fromJson(Map<String, dynamic> object) {
    dynamic data;
    if (object['data'] != null && object['data']['Capital_Id'] != null &&  object['data']['Amount'] != null) {
      data = DataAdvanceCapitalNotificationModel(
        amount: object['data']['Amount'] as double,
        capitalId: object['data']['Capital_Id'] as int
      );
    }

    return Alert(
      data: object['data'] == null ? {} : data,
      icon: object['icon'] ?? 'info',
      id: object['id'] as int,
      message: object['message'] ?? '',
      title: object['title'] ?? ''
    );
  }
}