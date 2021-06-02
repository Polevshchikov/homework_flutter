import 'package:dio/dio.dart';
import 'package:my_mobx/models/job.dart';
import 'package:meta/meta.dart';

/// Сервис работ
class JobService {
  final Dio dio;
  JobService({@required this.dio});

  Future<List<Job>> searchJobs(String query) => _getJobFromUrl(
      'https://jobs.github.com/positions.json?description=$query');

  Future<List<Job>> _getJobFromUrl(String url) async {
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      List<Job> data =
          response.data.map<Job>((item) => Job.fromJson(item)).toList();
      return data;
    } else {
      throw Exception('Error loading ...');
    }
  }
}
