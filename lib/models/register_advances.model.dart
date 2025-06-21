import 'package:prestaqi/models/advance.model.dart';
import 'package:prestaqi/models/details_advance.model.dart';

class RegisterAdvancesModel {
  late DetailsAdvanceModel forPayment;
  late List<AdvanceModel> currents;
  late List<AdvanceModel> befores;

  RegisterAdvancesModel({
    required this.forPayment,
    required this.currents,
    required this.befores
  });

  factory RegisterAdvancesModel.fromJson(Map<String, dynamic> object) {
    Iterable currents = (object['currents'] as Iterable);
    Iterable befores  = (object['befores'] as Iterable);

    return RegisterAdvancesModel(
      forPayment: DetailsAdvanceModel.fromJson(object['for_Payment'] ?? {}),
      currents: currents.map((e) => AdvanceModel.fromJson(e)).toList(),
      befores: befores.map((e) => AdvanceModel.fromJson(e)).toList()
    );
  }
}