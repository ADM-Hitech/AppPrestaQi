import 'dart:convert';

class MyProfileModel {
  late String firstName;
  late String lastName;
  late int companyId;
  late String identify;
  late String contractNumber;
  late String position;
  late double netMonthlySalary;
  late String rfc;
  late int interestRate;
  late String seniorityCompany;
  late DateTime birthDate = DateTime.now();
  late DateTime startDatePrestaQi = DateTime.now();
  late int age;
  late int genderId;
  late int institutionId;
  late String clabe;
  late String accountNumber;
  late bool enabled;
  late int moratoruimInterestRate;
  late int periodId;
  late String mail;
  late String mailMandateLatter;
  late DateTime? deletedAt;
  late String periodName;
  late String companyName;
  late String advances;
  late String institutionName;
  late int type;
  late String typeName;
  late int id;
  late DateTime createdAt = DateTime.now();
  late DateTime updatedAt = DateTime.now();
  late bool isBlocked;
  late String urlCartaMandato;
  late String typeContract;

  MyProfileModel({
    this.firstName = '',
    this.lastName = '',
    this.companyId = 0,
    this.identify = '',
    this.contractNumber = '',
    this.position = '',
    this.netMonthlySalary = 0,
    this.rfc = '',
    this.interestRate = 0,
    this.seniorityCompany = '',
    DateTime? birthDate,
    this.age = 0,
    this.genderId = 0,
    this.institutionId = 0,
    this.clabe = '',
    this.accountNumber = '',
    this.enabled = false,
    this.moratoruimInterestRate = 0,
    this.periodId = 0,
    this.mail = '',
    this.mailMandateLatter = '',
    DateTime? deletedAt,
    this.periodName = '',
    this.companyName = '',
    this.advances = '',
    this.institutionName = '',
    this.type = 0,
    this.typeName = '',
    this.id = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isBlocked = false,
    DateTime? startDatePrestaQi,
    this.typeContract = ''
  }) {
    this.birthDate = birthDate ?? DateTime.now();
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
    this.startDatePrestaQi = startDatePrestaQi ?? DateTime.now();

    if (deletedAt != null) {
      this.deletedAt = deletedAt;
    }
  }

  factory MyProfileModel.fromJson(Map<String, dynamic> object) {
    return MyProfileModel(
      firstName: object['first_Name'] ?? '',
      lastName: object['last_Name'] ?? '',
      companyId: object['company_Id'] as int,
      identify: object['identify'] ?? '',
      contractNumber: object['contract_number'] ?? '',
      position: object['position'] ?? '',
      netMonthlySalary: object['net_Monthly_Salary'] as double,
      rfc: object['rfc'] ?? '',
      interestRate: object['interest_Rate'] as int,
      seniorityCompany: object['seniority_Company'] ?? '',
      birthDate: DateTime.tryParse(object['birth_Date'] ?? '0000-00-00'),
      age: object['age'] as int,
      genderId: object['gender_Id'] as int,
      institutionId: object['institution_Id'] as int,
      clabe: object['clabe'] ?? '',
      accountNumber: object['account_Number'] ?? '',
      enabled: object['enabled'] as bool,
      moratoruimInterestRate: object['moratoruim_Interest_Rate'] as int,
      periodId: object['period_Id'] as int,
      mail: object['mail'] ?? '',
      mailMandateLatter: object['mail_Mandate_Latter'] ?? '',
      deletedAt: DateTime.tryParse(object['deleted_At'] ?? '0000-00-00'),
      periodName: object['period_Name'] ?? '',
      companyName: object['company_Name'] ?? '',
      advances: object['advances'] ?? '',
      institutionName: object['institution_Name'] ?? '',
      type: object['type'] as int,
      typeName: object['typeName'] ?? '',
      id: object['id'] as int,
      createdAt: DateTime.tryParse(object['created_at'] ?? '0000-00-00'),
      updatedAt: DateTime.tryParse(object['created_at'] ?? '0000-00-00'),
      isBlocked: object['is_Blocked'] as bool,
      startDatePrestaQi: DateTime.tryParse(object['start_Date_Prestaqi'] ?? '0000-00-00'),
      typeContract: object['typeContract']['code'] ?? ''
    );
  }

  String toJson() => json.encode({
    "first_Name": firstName,
    "last_Name": lastName,
    "company_Id": companyId,
    "identify": identify,
    "contract_number": contractNumber,
    "position": position,
    "net_Monthly_Salary": netMonthlySalary,
    "rfc": rfc,
    "interest_Rate": interestRate,
    "seniority_Company": seniorityCompany,
    "birth_Date": birthDate,
    "age": age,
    "gender_Id": genderId,
    "institution_Id": institutionId,
    "clabe": clabe,
    "account_Number": accountNumber,
    "enabled": enabled,
    "moratoruim_Interest_Rate": moratoruimInterestRate,
    "period_Id": periodId,
    "mail": mail,
    "mail_Mandate_Latter": mailMandateLatter,
    "deleted_At": deletedAt,
    "period_Name": periodName,
    "company_Name": companyName,
    "advances": advances,
    "institution_Name": institutionName,
    "type": type,
    "typeName": typeName,
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt
  });
}