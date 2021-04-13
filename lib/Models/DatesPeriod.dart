class DatesPeriod {
  DateTime initial;
  DateTime finish;

  DatesPeriod({this.initial, this.finish});

  factory DatesPeriod.fromJson(Map<String, dynamic> json) {
    return DatesPeriod(
      initial: DateTime.parse(json['item1'] ?? DateTime.now().toString()),
      finish: DateTime.parse(json['item2'] ?? DateTime.now().toString())
    );
  }
}