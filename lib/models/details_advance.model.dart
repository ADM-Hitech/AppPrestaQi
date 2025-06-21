class DetailsAdvanceModel {
  late int? advanceId;
  late double principalPayment;
  late double totalPayment;
  late double interest;
  late double vat;
  late DateTime datePayment = DateTime.now();
  late double initialBalance;
  late double finalBalance;
  late int daysForPayments;
  late int paidStatus;
  late int accreditedId;
  late int id;
  late String bankName;
  late String accountNumber;
  late DateTime created = DateTime.now();

  DetailsAdvanceModel({
    this.advanceId,
    this.principalPayment = 0,
    this.totalPayment = 0,
    this.interest = 0,
    this.vat = 0,
    DateTime? datePayment,
    this.initialBalance = 0,
    this.finalBalance = 0,
    this.daysForPayments = 0,
    this.paidStatus = 0,
    this.accreditedId = 0,
    this.id = 0,
    this.bankName = '',
    this.accountNumber = '',
    DateTime? created
  }) {
    if (datePayment != null) {
      this.datePayment = datePayment;
    }

    if (created != null) {
      this.created = created;
    }
  }

  factory DetailsAdvanceModel.fromJson(Map<String, dynamic> object) {

    if (object.isEmpty) {
      return DetailsAdvanceModel();
    }

    return DetailsAdvanceModel(
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
      bankName: object['bank_Name'] ?? '',
      accountNumber: object['account_Number'] ?? '',
      created: DateTime.tryParse(object['created_at'] ?? '0000-00-00')
    );
  }
}