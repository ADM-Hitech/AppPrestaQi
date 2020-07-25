import 'DataAdvanceCapitalNotification.dart';

class Alert {
  int id;
  String icon;
  String title;
  String message;
  dynamic data;

  Alert({
    this.id,
    this.icon,
    this.title,
    this.message,
    this.data
  });

  factory Alert.fromJson(Map<String, dynamic> object) {
    var data;
    if (object['data'] != null && object['data']['Capital_Id'] != null &&  object['data']['Amount'] != null) {
      data = new DataAdvanceCapitalNotification(
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