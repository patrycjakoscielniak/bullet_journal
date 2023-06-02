class HolidaysModel {
  HolidaysModel({
    required this.year,
    required this.month,
    required this.day,
    required this.eventName,
  });
  final int year;
  final int month;
  final int day;
  final String eventName;

  DateTime get start {
    return DateTime(year, month, day);
  }

  DateTime get end {
    return DateTime(year, month, day);
  }

  HolidaysModel.fromJson(Map<String, dynamic> json)
      : eventName = json['name'],
        year = json['date']['datetime']['year'],
        month = json['date']['datetime']['month'],
        day = json['date']['datetime']['day'];
}
