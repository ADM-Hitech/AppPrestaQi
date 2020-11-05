class DetailsAdvance {
  int advanceId;
  double principalPayment;
  double totalPayment;
  double interest;
  double vat;
  DateTime datePayment;
  double initialBalance;
  double finalBalance;
  int daysForPayments;
  int paidStatus;
  int accreditedId;
  int id;
  String bankName;
  String accountNumber;

  DetailsAdvance({
    this.advanceId,
    this.principalPayment,
    this.totalPayment,
    this.interest,
    this.vat,
    this.datePayment,
    this.initialBalance,
    this.finalBalance,
    this.daysForPayments,
    this.paidStatus,
    this.accreditedId,
    this.id,
    this.bankName,
    this.accountNumber
  });

  factory DetailsAdvance.fromJson(Map<String, dynamic> object) {
    return DetailsAdvance(
      advanceId: object['advance_Id'] as int,
      principalPayment: object['principal_Payment'] as double,
      totalPayment: object['total_Payment'] as double,
      interest: object['interest'] as double,
      vat: object['vat'] as double,
      datePayment: DateTime.tryParse(object['date_Payment'] ?? '0000-00-00'),
      initialBalance: object['initial_Balance'] as double,
      finalBalance: object['final_Balance'] as double,
      daysForPayments: object['days_For_Payments'] as int,
      paidStatus: object['paid_Status'] as int,
      accreditedId: object['accredited_Id'] as int,
      id: object['id'] as int,
      bankName: object['bank_Name'],
      accountNumber: object['account_Number']
    );
  }
}