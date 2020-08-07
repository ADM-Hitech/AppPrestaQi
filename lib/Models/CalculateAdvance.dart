import 'package:prestaQi/Models/MyProfile.dart';

class CalculateAdvance {
  int accreditedId;
  double amount;
  DateTime dateAdvance;
  int requestedDay;
  double totalWithhold;
  int comission;
  bool enabled;
  int paidStatus;
  double maximumAmount;
  int id;
  double interest;
  double vat;
  double subTotal;
  double interestMoratorium;
  double dayMoratorium;
  double promotionalSetting;
  int dayForPayment;
  double maximunAmount;
  DateTime createdAt;
  DateTime updatedAt;
  String urlCartaMandato;
  MyProfileModel user;

  CalculateAdvance({
    this.accreditedId,
    this.amount,
    this.dateAdvance,
    this.requestedDay,
    this.totalWithhold,
    this.comission,
    this.enabled,
    this.paidStatus,
    this.maximumAmount,
    this.id,
    this.interest,
    this.vat,
    this.subTotal,
    this.interestMoratorium,
    this.dayMoratorium,
    this.promotionalSetting,
    this.dayForPayment,
    this.maximunAmount,
    this.createdAt,
    this.updatedAt,
    this.urlCartaMandato,
    this.user
  });

  factory CalculateAdvance.fromJson(Map<String, dynamic> object) {
    return CalculateAdvance(
      accreditedId: object['accredited_Id'] as int,
      amount: object['amount'] as double,
      dateAdvance: DateTime.tryParse(object['date_Advance'] ?? '0000-00-00'),
      requestedDay: object['requested_Day'] as int,
      totalWithhold: object['total_Withhold'] as double,
      comission: object['comission'] as int,
      enabled: object['enabled'] as bool,
      paidStatus: object['paid_Status'] as int,
      maximumAmount: object['maximum_Amount'] as double,
      id: object['id'] as int,
      createdAt: DateTime.tryParse(object['created_at'] ?? '0000-00-00'),
      updatedAt: DateTime.tryParse(object['updated_at'] ?? '0000-00-00'),
      interest: object['interest'] as double,
      vat: object['vat'] as double,
      subTotal: object['subtotal'] as double,
      interestMoratorium: object['interest_Moratorium'] as double,
      dayMoratorium: object['day_Moratorium'] as double,
      promotionalSetting: object['promotional_Setting'] as double,
      dayForPayment: object['day_For_Payment'] as int,
      maximunAmount: object['maximum_Amount'] as double,
    );
  }
}