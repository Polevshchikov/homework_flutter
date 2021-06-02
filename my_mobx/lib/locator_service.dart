import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_mobx/services/job_service.dart';

final sl = GetIt.instance;

class Services {
  final Dio dio = Dio();

  JobService jobService;

  void init() {
    jobService = JobService(dio: dio);
  }
}
