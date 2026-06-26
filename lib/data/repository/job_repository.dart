import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/model/job_model.dart';

class JobRepository {
  final JobDatasource datasource;

  JobRepository(
    this.datasource,
  );

  static const String cacheKey =
    'cached_jobs';

Future<List<JobModel>> getJobs({
  required String query,
  int page = 1,
  }) async {
    final data = await datasource.getJobs(
      query: query,
      page: page,
    );

    return data
        .map<JobModel>(
          (job) => JobModel.fromJson(job),
        )
        .toList();
  }

}