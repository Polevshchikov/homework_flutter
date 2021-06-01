import 'package:dio/dio.dart';
import 'package:my_mobx/models/job.dart';

class JobProvider {
  static Future<List<Job>> searchJobs(String query) => _getJobFromUrl(
      'https://jobs.github.com/positions.json?description=$query');

  static Future<List<Job>> _getJobFromUrl(String url) async {
    Dio _dio = Dio();
    print(url);
    Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      List<Job> data =
          response.data.map<Job>((item) => Job.fromJson(item)).toList();
      return data;
    } else {
      throw Exception('Error loading ...');
    }
  }
}
