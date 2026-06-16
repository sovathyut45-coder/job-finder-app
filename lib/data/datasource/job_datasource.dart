import 'package:job_finder_app/core/network/dio_client.dart';

class JobDatasource {
  Future<List<dynamic>> getJobs({
    required String query,
    int page = 1,
  }) async {

    final response = await DioClient.dio.get(
      '/job-board-api',
      queryParameters: {
        'page': page,
      },
    );

    final List jobs = response.data['data'];
    print(response.data['data'][0]);

    final filteredJobs = jobs.where(
      (job) {
        return job['title']
            .toString()
            .toLowerCase()
            .contains(
              query.toLowerCase(),
            );
      },
    ).toList();

    return filteredJobs.map(
      (job) => {
        'job_id': job['slug'] ?? '',

        'job_title': job['title'] ?? '',

        'employer_name': job['company_name'] ?? '',

        'employer_logo': '',

        'job_location': job['location'] ?? 'Remote',

        'job_city': '',

        'job_country': '',

        'job_employment_type':
            job['job_types'] != null
                ? (job['job_types'] as List).join(', ')
                : '',

        'job_description':
            job['description'] ?? '',

        'job_apply_link':
            job['url'] ?? '',

        'job_min_salary': 0,

        'job_max_salary': 0,
      },
    ).toList();
  }


  // Future<List<dynamic>> getJobDetail(
  //    String id,
  // ) async {

  //   try {
  //     final response = await DioClient.dio.get(
  //       '/job-board-api',
  //       queryParameters: {
  //         'job_id': id,
  //       },
  //     );
  //     return response.data['data'];
  //   } catch (e) {
  //     print(e);
  //   }

  //   return [];
  // }

}