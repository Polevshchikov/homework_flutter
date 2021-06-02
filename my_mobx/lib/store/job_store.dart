import 'package:mobx/mobx.dart';
import 'package:my_mobx/locator_service.dart';
import 'package:my_mobx/models/job.dart';
import 'package:my_mobx/services/job_service.dart';

part 'job_store.g.dart';

class JobStore = _JobStore with _$JobStore;

abstract class _JobStore with Store {
  JobService jobService;
  _JobStore() {
    jobService = sl.get<Services>().jobService;
  }

  @observable
  String query = '';

  @observable
  List<Job> jobs = [];

  @observable
  bool isLoading = false;

  @observable
  bool isInitText = true;

  @observable
  bool loadingError = false;

  @action
  void setQuery(String text) {
    query = text;
  }

  @action
  void initText() {
    isInitText = false;
  }

  @action
  Future<void> loadJob() async {
    loadingError = false;
    isLoading = true;
    jobs.clear();
    try {
      jobs = await jobService.searchJobs(query);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      loadingError = true;
    }
  }
}
