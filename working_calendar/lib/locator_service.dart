import 'package:get_it/get_it.dart';
import 'package:working_calendar/services/repository.dart';

final sl = GetIt.instance;

class Services {
  late DateRepository dateRepository;

  void init() {
    dateRepository = DateRepository();
  }
}
