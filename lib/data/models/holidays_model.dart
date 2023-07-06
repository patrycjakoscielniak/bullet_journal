import 'package:freezed_annotation/freezed_annotation.dart';
part 'holidays_model.freezed.dart';

@freezed
class HolidayModel with _$HolidayModel {
  const HolidayModel._();
  factory HolidayModel({
    required String name,
    required DateTime date,
    required String type,
  }) = _HolidayModel;

  factory HolidayModel.fromJson(Map<String, dynamic> parsedJson) {
    return HolidayModel(
        name: parsedJson['localName'].toString(),
        date: DateTime.parse(parsedJson['date']),
        type: parsedJson['type'].toString());
  }
}
