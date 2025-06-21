class AdvanceModel {
  late int accreditedId;
  late double amount;
  late DateTime dateAdvance;
  late int requestedDay;
  late double totalWithhold;
  late double comission;
  late bool enabled;
  late int paidStatus;
  late double interest;
  late double vat;
  late double subTotal;
  late double interestMoratorium;
  late double dayMoratorium;
  late DateTime limitDate;
  late double promotionSetting;
  late int dayForPayment;
  late int interestRate;
  late double maximunAmount;
  late double initial;
  late double finalAmount;
  late int id;
  late List<DetailsByAdvance> detailsByAdvance;
  late DateTime created;

  AdvanceModel({
    this.accreditedId = 0,
    this.amount = 0,
    DateTime? dateAdvance,
    this.requestedDay = 0,
    this.totalWithhold = 0,
    this.comission = 0,
    this.enabled = false,
    this.paidStatus = 0,
    this.interest = 0,
    this.vat = 0,
    this.subTotal = 0,
    this.interestMoratorium = 0,
    this.dayMoratorium = 0,
    DateTime? limitDate,
    this.promotionSetting = 0,
    this.dayForPayment = 0,
    this.interestRate = 0,
    this.maximunAmount = 0,
    this.initial = 0,
    this.finalAmount = 0,
    this.id = 0,
    List<DetailsByAdvance>? detailsByAdvance,
    DateTime? created
  }) {
    if (dateAdvance != null) {
      this.dateAdvance = dateAdvance;
    }

    if (created != null) {
      this.created = created;
    }

    if (limitDate != null) {
      this.limitDate = limitDate;
    }

    if (detailsByAdvance != null) {
      this.detailsByAdvance = detailsByAdvance;
    }

  }

  factory AdvanceModel.fromJson(Map<String, dynamic> object) {
    Iterable details = (object['details'] ?? []) as Iterable;

    return AdvanceModel(
      accreditedId: object['accredited_Id'] as int,
      amount: object['amount'] as double,
      dateAdvance: DateTime.tryParse(object['date_Advance'] ?? '0000-00-00'),
      requestedDay: object['requested_Day'] as int,
      totalWithhold: object['total_Withhold'] as double,
      comission: double.tryParse((object['comission'] ?? 0).toString()) ?? 0,
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
  late DateTime datePayment;
  double amount;

  DetailsByAdvance({
    DateTime? datePayment,
    this.amount = 0
  }) {
    if (datePayment != null) {
      this.datePayment = datePayment;
    }
  }

  factory DetailsByAdvance.fromJson(Map<String, dynamic> object) {
    return DetailsByAdvance(
      datePayment: DateTime.tryParse(object['detail']['date_Payment'] ?? '0000-00-00'),
      amount: object['amount']
    );
  }
}