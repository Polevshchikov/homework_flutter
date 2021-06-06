import 'package:working_calendar/models/data_entity.dart';

import 'api_provider.dart';

class DataRepository {
  DataProvider _dataProvider = DataProvider();

  Future<List<Months>> getAllData(int queryYear) =>
      _dataProvider.getData(queryYear);
}
