import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class HolidaysRemoteDioDataSource {
  Future<List<Map<String, dynamic>>?> getHolidays() async {
    final response = await Dio().get<List<dynamic>>(
        'https://calendarific.com/api/v2/holidays?api_key=da36cccdcffa6626e9a4c6960e59d722942e9936&country=PL&year=2023');
    final listDynamic = response.data;
    if (listDynamic == null) {
      return null;
    }
    return listDynamic.map((e) => e as Map<String, dynamic>).toList();
  }
}
