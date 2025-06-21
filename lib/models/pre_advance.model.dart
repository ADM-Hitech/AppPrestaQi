import 'package:prestaqi/models/advance.model.dart';
import 'package:prestaqi/models/details_advance.model.dart';
import 'package:prestaqi/models/my_profile.model.dart';

class PreAdvanceModel {
  late AdvanceModel advance;
  late List<DetailsAdvanceModel> details;
  late MyProfileModel user;

  PreAdvanceModel({
    AdvanceModel? advance,
    List<DetailsAdvanceModel>? details,
    MyProfileModel? user,
  }) {
    if (advance != null) {
      this.advance = advance;
    }

    if (details != null) {
      this.details = details;
    }

    if (user != null) {
      this.user = user;
    }
  }

  factory PreAdvanceModel.fromJson(Map<String, dynamic> object) {
    Iterable detailsIterable = (object['details'] as Iterable);

    return PreAdvanceModel(
      advance: AdvanceModel.fromJson(object['advance'] ?? {}),
      details: detailsIterable.map((e) => DetailsAdvanceModel.fromJson(e)).toList()
    );
  }
}