import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/model/job_model.dart';

class JobRepository {
  final JobDatasource datasource;

  JobRepository(
    this.datasource,
  );

Future<List<JobModel>> getJobs({
  required String query,
  int page = 1,
  int numPages = 1,
  }) async {
    final data = await datasource.getJobs(
      query: query,
      page: page,
      numPages: numPages,
    );

    return data
        .map<JobModel>(
          (job) => JobModel.fromJson(job),
        )
        .toList();
  }

  Future<List<JobModel>> getJobDetail(String id) async {
    final data = await datasource.getJobDetail(id);

  //   for (final job in data) {
  //   print(job['employer_logo']);
  // }

    return data.map<JobModel>(
      (job) => JobModel.fromJson(job)
    )
    .toList();
    
  }
}