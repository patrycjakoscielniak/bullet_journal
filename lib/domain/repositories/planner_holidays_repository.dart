import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../data/models/holidays_model.dart';
import '../../data/remote_data_sources/planner_remote_data_source.dart';

@injectable
class PlannerHolidaysRepository {
  PlannerHolidaysRepository(this._plannerRemoteDataSource);
  final PlannerRemoteDataSource _plannerRemoteDataSource;
  Future<List<HolidayModel>> getHolidays(String country) async {
    final response = await _plannerRemoteDataSource.fetchHolidays(country);
    if (response == '') {
      return [];
    }
    var dynamic = jsonDecode(response);
    final list =
        (dynamic as List).map((data) => HolidayModel.fromJson(data)).toList();
    return list;
  }
}
