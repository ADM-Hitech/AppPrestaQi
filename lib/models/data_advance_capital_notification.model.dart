import 'dart:convert';

class DataAdvanceCapitalNotificationModel {
  late int capitalId;
  late double amount;
  late DateTime createdAt;

  DataAdvanceCapitalNotificationModel({
    this.capitalId = 0,
    this.amount = 0,
    DateTime? createdAt,
  }) {
    if (createdAt != null) {
      this.createdAt = createdAt;
    }
  }

  String toJson() => json.encode({
    'Capital_Id': capitalId,
    'Amount': amount,
    'created_at': createdAt,
  });
}