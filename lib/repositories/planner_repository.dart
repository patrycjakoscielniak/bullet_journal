import 'package:my_bullet_journal/app/data/planner_remote_data_source.dart';
import 'package:my_bullet_journal/models/planner_item_model.dart';

class PlannerRepository {
  PlannerRepository({required this.remoteDataSource});

  final HolidaysRemoteDioDataSource remoteDataSource;

  Future<List<HolidaysModel>> getHolidays() async {
    final json = await remoteDataSource.getHolidays();
    if (json == null) {
      return [];
    }
    return json.map((item) => HolidaysModel.fromJson(item)).toList();
  }
}
