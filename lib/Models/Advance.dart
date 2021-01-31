import 'dart:convert' as convert;

class Advance {
  int accreditedId;
  double amount;
  DateTime dateAdvance;
  int requestedDay;
  double totalWithhold;
  int comission;
  bool enabled;
  int paidStatus;
  double interest;
  double vat;
  double subTotal;
  double interestMoratorium;
  double dayMoratorium;
  DateTime limitDate;
  double promotionSetting;
  int dayForPayment;
  int interestRate;
  double maximunAmount;
  double initial;
  double finalAmount;
  int id;
  List<DetailsByAdvance> detailsByAdvance;
  DateTime created;

  Advance({
    this.accreditedId,
    this.amount,
    this.dateAdvance,
    this.requestedDay,
    this.totalWithhold,
    this.comission,
    this.enabled,
    this.paidStatus,
    this.interest,
    this.vat,
    this.subTotal,
    this.interestMoratorium,
    this.dayMoratorium,
    this.limitDate,
    this.promotionSetting,
    this.dayForPayment,
    this.interestRate,
    this.maximunAmount,
    this.initial,
    this.finalAmount,
    this.id,
    this.detailsByAdvance,
    this.created
  });

  factory Advance.fromJson(Map<String, dynamic> object) {
    Iterable details = (object['details'] as Iterable) ?? convert.json.decode('[]');

    return Advance(
      accreditedId: object['accredited_Id'] as int,
      amount: object['amount'] as double,
      dateAdvance: DateTime.tryParse(object['date_Advance'] ?? '0000-00-00'),
      requestedDay: object['requested_Day'] as int,
      totalWithhold: object['total_Withhold'] as double,
      comission: object['comission'] as int,
      enabled: object['enabled'] as bool,
      paidStatus: object['paid_Status'] as int,
      interest: object['interest'] as double,
      vat: object['vat'] as double,
      subTotal: object['subtotal'] as double,
      interestMoratorium: object['interest_Moratorium'] as double,
      dayMoratorium: object['day_Moratorium'] as double,
      limitDate: DateTime.tryParse(object['limit_Date'] ?? '0000-00-00'),
      promotionSetting: object['promotional_Setting'] as double,
      dayForPayment: object['day_For_Payment'] as int,
      interestRate: object['interest_Rate'] as int,
      maximunAmount: object['maximum_Amount'] as double,
      initial: object['initial'] as double,
      finalAmount: object['final'] as double,
      id: object['id'] as int,
      detailsByAdvance: details.map((d) => DetailsByAdvance.fromJson(d)).toList(),
      created: DateTime.tryParse(object['created_at'] ?? '0000-00-00')
    );
  }
}

class DetailsByAdvance {
  DateTime datePayment;
  double amount;

  DetailsByAdvance({
    this.datePayment,
    this.amount
  });

  factory DetailsByAdvance.fromJson(Map<String, dynamic> object) {
    return DetailsByAdvance(
      datePayment: DateTime.tryParse(object['detail']['date_Payment'] ?? '0000-00-00'),
      amount: object['amount']
    );
  }
}