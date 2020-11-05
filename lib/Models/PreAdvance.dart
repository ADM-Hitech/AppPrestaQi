import 'package:prestaQi/Models/Advance.dart';
import 'package:prestaQi/Models/DetailsAdvance.dart';
import 'dart:convert' as convert;

import 'package:prestaQi/Models/MyProfile.dart';

class PreAdvance {
  Advance advance;
  List<DetailsAdvance> details;
  MyProfileModel user;

  PreAdvance({
    this.advance,
    this.details,
    this.user
  });

  factory PreAdvance.fromJson(Map<String, dynamic> object) {
    Iterable detailsIterable = (object['details'] as Iterable) ?? convert.json.decode('[]');

    return PreAdvance(
      advance: Advance.fromJson(object['advance'] ?? {}),
      details: detailsIterable.map((e) => DetailsAdvance.fromJson(e)).toList()
    );
  }
}