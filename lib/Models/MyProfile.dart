import 'dart:convert';

class MyProfileModel {
  String firstName;
  String lastName;
  int companyId;
  String identify;
  String contractNumber;
  String position;
  double netMonthlySalary;
  String rfc;
  int interestRate;
  String seniorityCompany;
  DateTime birthDate;
  int age;
  int genderId;
  int institutionId;
  String clabe;
  String accountNumber;
  bool enabled;
  int moratoruimInterestRate;
  int periodId;
  String mail;
  String mailMandateLatter;
  DateTime deletedAt;
  String periodName;
  String companyName;
  String advances;
  String institutionName;
  int type;
  String typeName;
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool isBlocked;
  String urlCartaMandato;

  MyProfileModel({
    this.firstName,
    this.lastName,
    this.companyId,
    this.identify,
    this.contractNumber,
    this.position,
    this.netMonthlySalary,
    this.rfc,
    this.interestRate,
    this.seniorityCompany,
    this.birthDate,
    this.age,
    this.genderId,
    this.institutionId,
    this.clabe,
    this.accountNumber,
    this.enabled,
    this.moratoruimInterestRate,
    this.periodId,
    this.mail,
    this.mailMandateLatter,
    this.deletedAt,
    this.periodName,
    this.companyName,
    this.advances,
    this.institutionName,
    this.type,
    this.typeName,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isBlocked
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> object) {
    return MyProfileModel(
      firstName: object['first_Name'] ?? '',
      lastName: object['last_Name'] ?? '',
      companyId: object['company_Id'] as int ?? 0,
      identify: object['identify'] ?? '',
      contractNumber: object['contract_number'] ?? '',
      position: object['position'] ?? '',
      netMonthlySalary: object['net_Monthly_Salary'] as double ?? 0.0,
      rfc: object['rfc'] ?? '',
      interestRate: object['interest_Rate'] as int ?? 0,
      seniorityCompany: object['seniority_Company'] ?? '',
      birthDate: DateTime.tryParse(object['birth_Date'] ?? '0000-00-00'),
      age: object['age'] as int ?? 0,
      genderId: object['gender_Id'] as int ?? 0,
      institutionId: object['institution_Id'] as int ?? 0,
      clabe: object['clabe'] ?? '',
      accountNumber: object['account_Number'] ?? '',
      enabled: object['enabled'] as bool ?? true,
      moratoruimInterestRate: object['moratoruim_Interest_Rate'] as int,
      periodId: object['period_Id'] as int ?? 0,
      mail: object['mail'] ?? '',
      mailMandateLatter: object['mail_Mandate_Latter'] ?? '',
      deletedAt: DateTime.tryParse(object['deleted_At'] ?? '0000-00-00'),
      periodName: object['period_Name'] ?? '',
      companyName: object['company_Name'] ?? '',
      advances: object['advances'] ?? '',
      institutionName: object['institution_Name'] ?? '',
      type: object['type'] as int ?? 0,
      typeName: object['typeName'] ?? '',
      id: object['id'] as int ?? 0,
      createdAt: DateTime.tryParse(object['created_at'] ?? '0000-00-00'),
      updatedAt: DateTime.tryParse(object['created_at'] ?? '0000-00-00'),
      isBlocked: object['is_Blocked'] as bool ?? false
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