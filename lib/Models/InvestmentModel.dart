import 'package:prestaQi/Models/DetailsInvestmentModel.dart';
import 'dart:convert' as convert;

class InvestmentModel {
  int capitalID;
  double amount;
  int interestRate;
  double annualInterestPayment;
  double total;
  DateTime startDate;
  DateTime endDate;
  int periodId;
  int interestArrears;
  String enabled;
  double interestPayable;
  double quantityInterestArrears;
  double totalInterest;
  double vat;
  double vatRetention;
  double isrRetention;
  double netInterest;
  DateTime payDayLimit;
  int dayOverdue;
  List<DetailsInvestmentModel> details;

  InvestmentModel({
    this.capitalID,
    this.amount,
    this.interestRate,
    this.annualInterestPayment,
    this.total,
    this.startDate,
    this.endDate,
    this.periodId,
    this.interestArrears,
    this.enabled,
    this.interestPayable,
    this.quantityInterestArrears,
    this.totalInterest,
    this.vat,
    this.vatRetention,
    this.isrRetention,
    this.netInterest,
    this.payDayLimit,
    this.dayOverdue,
    this.details
  });

  factory InvestmentModel.fromJson(Map<String, dynamic> object) {
    Iterable details = (object['myInvestmentDetails'] as Iterable) ?? convert.json.decode('[]');

    return InvestmentModel(
      capitalID: object['capital_ID'] as int ?? 0,
      amount: object['amount'] as double ?? 0,
      interestRate: object['interest_Rate'] as int ?? 0,
      annualInterestPayment: object['annual_Interest_Payment'] as double ?? 0,
      total: object['total'] as double ?? 0,
      startDate: DateTime.tryParse(object['start_Date'] ?? '0000-00-00'),
      endDate: DateTime.tryParse(object['end_Date'] ?? '0000-00-00'),
      periodId: object['period_Id'] as int ?? 0,
      interestArrears: object['interest_Arrears'] as int ?? 0,
      enabled: object['enabled'] ?? 'Default',
      interestPayable: object['interest_Payable'] as double ?? 0,
      quantityInterestArrears: object['quantity_Interest_Arrears'] as double ?? 0,
      totalInterest: object['total_Interest'] as double ?? 0,
      vat: object['vat'] as double ?? 0,
      vatRetention: object['vat_Retention'] as double ?? 0,
      isrRetention: object['isr_Retention'] as double ?? 0,
      netInterest: object['net_Interest'] as double ?? 0,
      payDayLimit: DateTime.tryParse(object['pay_Day_Limit'] ?? '0000-00-00'),
      dayOverdue: object['day_Overdue'] as int ?? 0,
      details: details.map((detail) => DetailsInvestmentModel.fromJson(detail)).toList()
    );
  }
}