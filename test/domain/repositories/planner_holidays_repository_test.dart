import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_bullet_journal/data/models/holidays_model.dart';
import 'package:my_bullet_journal/data/remote_data_sources/planner_remote_data_source.dart';
import 'package:my_bullet_journal/domain/repositories/planner_holidays_repository.dart';

class MockPlannerRemoteDataSource extends Mock
    implements PlannerRemoteDataSource {}

void main() {
  late MockPlannerRemoteDataSource dataSource;
  late PlannerHolidaysRepository sut;

  setUp(() {
    dataSource = MockPlannerRemoteDataSource();
    sut = PlannerHolidaysRepository(dataSource);
  });

  group('getHolidays', () {
    test('should convert data from database to list<HolidayModel>', () async {
      //1
      when(
        () => dataSource.fetchHolidays('US'),
      ).thenAnswer(
        (_) async =>
            '[{"date": "2022-01-01", "localName":"holiday1", "type":"Public"},{"date": "2023-01-01", "localName":"holiday2", "type":"Public"}, {"date": "2023-01-01", "localName":"holiday3", "type":"Optional"}]',
      );
      //2
      final result = await sut.getHolidays('US');
      //3
      expect(result, [
        HolidayModel(
          name: 'holiday1',
          date: DateTime(2022, 1, 1),
          type: 'Public',
        ),
        HolidayModel(
          name: 'holiday2',
          date: DateTime(2023, 1, 1),
          type: 'Public',
        ),
        HolidayModel(
          name: 'holiday3',
          date: DateTime(2023, 1, 1),
          type: 'Optional',
        ),
      ]);
    });
  });
}
