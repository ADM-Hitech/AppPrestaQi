import 'package:prestaQi/Models/Advance.dart';
import 'package:prestaQi/Models/DetailsAdvance.dart';
import 'dart:convert' as convert;

class RegisterAdvances {
  DetailsAdvance forPayment;
  List<Advance> currents;
  List<Advance> befores;

  RegisterAdvances({
    this.forPayment,
    this.currents,
    this.befores
  });

  factory RegisterAdvances.fromJson(Map<String, dynamic> object) {
    Iterable currents = (object['currents'] as Iterable) ?? convert.json.decode('[]');
    Iterable befores  = (object['befores'] as Iterable) ?? convert.json.decode('[]');

    return RegisterAdvances(
      forPayment: DetailsAdvance.fromJson(object['for_Payment'] ?? {}),
      currents: currents.map((e) => Advance.fromJson(e)).toList(),
      befores: befores.map((e) => Advance.fromJson(e)).toList()
    );
  }
}