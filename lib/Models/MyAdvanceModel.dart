class MyAdvanceModel {
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
  DateTime createdAt;
  DateTime updatedAt;
  int interestRate;
  double interest;
  double vat;

  MyAdvanceModel({
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
    this.createdAt,
    this.updatedAt,
    this.interestRate,
    this.interest = 0,
    this.vat = 0
  });

  factory MyAdvanceModel.fromJson(Map<String, dynamic> object) {
    return MyAdvanceModel(
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
      interestRate: object['interest_Rate'] as int,
      interest: object['interest'] as double,
      vat: object['vat'] as double
    );
  }
}