class InfoBank {
  String clabe;
  String institutionName;
  String accountNumber;
  String firstName;
  String lastName;
  String contractNumber;
  double amount;
  String companyName;

  InfoBank({
    this.clabe,
    this.institutionName,
    this.accountNumber,
    this.firstName,
    this.lastName,
    this.contractNumber,
    this.amount,
    this.companyName
  });

  factory InfoBank.fromJson(Map<String, dynamic> object) {
    return InfoBank(
      clabe: object['clabe'] ?? '',
      institutionName: object['institution_Name'] ?? '',
      accountNumber: object['account_Number'] ?? '',
      firstName: object['first_Name'] ?? '',
      lastName: object['last_Name'] ?? '',
      contractNumber: object['contract_number'] ?? ''
    );
  }
}