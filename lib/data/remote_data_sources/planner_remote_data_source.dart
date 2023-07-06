import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class PlannerRemoteDataSource {
  Future<String> fetchHolidays(String country) async {
    final years = [
      '2020',
      '2021',
      '2022',
      '2023',
      '2024',
      '2025',
      '2026',
      '2027',
      '2028',
      '2029',
      '2030'
    ];
    String response = '';
    for (final year in years) {
      final url =
          Uri.parse('https://public-holiday.p.rapidapi.com/$year/$country');
      final getData = await http.get(url, headers: {
        "X-RapidAPI-Key": "139e0b9fa2msh89a1ebdff767cf4p156932jsn676885f8ec26",
        "X-RapidAPI-Host": "public-holiday.p.rapidapi.com"
      });
      if (getData.body.isEmpty) {
        return '';
      }
      response =
          '$response${getData.body.substring(1, getData.body.length - 1)},';
    }
    return response = '[${response.substring(0, response.length - 1)}]';
  }
}
