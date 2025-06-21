class CalculateAdvance {
  late int accreditedId;
  late double amount;
  late DateTime dateAdvance = DateTime.now();
  late int requestedDay;
  late double totalWithhold;
  late int comission;
  late bool enabled;
  late int paidStatus;
  late double maximumAmount;
  late int id;
  late double interest;
  late double vat;
  late double subTotal;
  late double interestMoratorium;
  late double dayMoratorium;
  late double promotionalSetting;
  late int dayForPayment;
  late double maximunAmount;
  late DateTime createdAt = DateTime.now();
  late DateTime updatedAt = DateTime.now();
  late String urlCartaMandato;
  late double latitude;
  late double longitude;

  CalculateAdvance({
    this.accreditedId = 0,
    this.amount = 0,
    this.requestedDay = 0,
    this.totalWithhold = 0,
    this.comission = 0,
    this.enabled = false,
    this.paidStatus = 0,
    this.maximumAmount = 0,
    this.id = 0,
    this.interest = 0,
    this.vat = 0,
    this.subTotal = 0,
    this.interestMoratorium = 0,
    this.dayMoratorium = 0,
    this.promotionalSetting = 0,
    this.dayForPayment = 0,
    this.maximunAmount = 0,
    this.urlCartaMandato = '',
    DateTime? dateAdvance,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? latitude,
    double? longitude
  }) {
    this.dateAdvance = dateAdvance ?? DateTime.now();
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
  }

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