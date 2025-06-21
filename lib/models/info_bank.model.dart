class InfoBankModel {
  String clabe;
  String institutionName;
  String accountNumber;
  String firstName;
  String lastName;
  String contractNumber;
  double amount;
  String companyName;
  int days;
  int commision;
  double totalAmount;

  InfoBankModel({
    this.clabe = '',
    this.institutionName = '',
    this.accountNumber = '',
    this.firstName = '',
    this.lastName = '',
    this.contractNumber = '',
    this.amount = 0,
    this.companyName = '',
    this.days = 0, 
    this.commision = 0,
    this.totalAmount = 0
  });

  factory InfoBankModel.fromJson(Map<String, dynamic> object) {
    return InfoBankModel(
      clabe: object['clabe'] ?? '',
      institutionName: object['institution_Name'] ?? '',
      accountNumber: object['account_Number'] ?? '',
      firstName: object['first_Name'] ?? '',
      lastName: object['last_Name'] ?? '',
      contractNumber: object['contract_number'] ?? ''
    );
  }
}