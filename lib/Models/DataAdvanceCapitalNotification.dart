import 'dart:convert';

class DataAdvanceCapitalNotification {
  int capitalId;
  double amount;
  DateTime createdAt;

  DataAdvanceCapitalNotification({this.capitalId, this.amount, this.createdAt});
  
  String toJson() => json.encode({
    'Capital_Id': capitalId,
    'Amount': amount,
    'created_at': createdAt
  });
}