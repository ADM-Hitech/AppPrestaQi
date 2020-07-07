class DetailsInvestmentModel {
  int period;
  int capitalId;
  DateTime startDate;
  DateTime endDate;
  double outstandingBalance;
  double principalPayment;
  double interestPayment;
  double defaultInterest;
  double promotionalSettings;
  double vat;
  double vatRetention;
  double isrRetention;
  double payment;
  bool isPayment;
  DateTime payDayLimit;
  bool isPeriodActual;
  int id;
  DateTime createdAt;
  DateTime updatedAt;

  DetailsInvestmentModel({
    this.period,
    this.capitalId,
    this.startDate,
    this.endDate,
    this.outstandingBalance,
    this.principalPayment,
    this.interestPayment,
    this.defaultInterest,
    this.promotionalSettings,
    this.vat,
    this.vatRetention,
    this.isrRetention,
    this.payment,
    this.isPayment,
    this.payDayLimit,
    this.isPeriodActual,
    this.id,
    this.createdAt,
    this.updatedAt
  });

  factory DetailsInvestmentModel.fromJson(Map<String, dynamic> object) {
    return DetailsInvestmentModel(
      period: object['period'] as int ?? 0,
      capitalId: object['capital_Id'] as  int ?? 0,
      startDate: DateTime.tryParse(object['start_Date'] ?? '0000-00-00'),
      endDate: DateTime.tryParse(object['end_Date'] ?? '0000-00-00'),
      outstandingBalance: object['outstanding_Balance'] as double ?? 0,
      principalPayment: object['principal_Payment'] as double ?? 0,
      interestPayment: object['interest_Payment'] as double ?? 0,
      defaultInterest: object['default_Interest'] as double ?? 0,
      promotionalSettings: object['promotional_Settings'] as double ?? 0,
      vat: object['vat'] as double ?? 0,
      vatRetention: object['vat_Retention'] as double ?? 0,
      isrRetention: object['isr_Retention'] as double ?? 0,
      payment: object['payment'] as double ?? 0,
      isPayment: object['isPayment'] as bool ?? true,
      payDayLimit: DateTime.tryParse(object['pay_Day_Limit'] ?? '0000-00-00'),
      isPeriodActual: object['isPeriodActual'] as bool ?? true,
      id: object['id'] as int ?? 0,
      createdAt: DateTime.tryParse(object['created_at'] ?? '0000-00-00'),
      updatedAt: DateTime.tryParse(object['updated_at'] ?? '0000-00-00')
    );
  }
}