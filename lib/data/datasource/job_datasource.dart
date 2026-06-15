import 'package:job_finder_app/core/network/dio_client.dart';

class JobDatasource {
  Future<List<dynamic>> getJobs({
    required String query,
    int page = 1,
  }) async {

    final response = await DioClient.dio.get(
      '/gb/search/$page',
      queryParameters: {
        'what': query,
        'results_per_page': 20,
      },
    );

    final List jobs = response.data['results'];

    return jobs.map(
      (job) => {
        'job_id': job['id']?.toString() ?? '',

        'job_title': job['title'] ?? '',

        'employer_name':
            job['company']?['display_name'] ?? '',

        'employer_logo': '',

        'job_location':
            job['location']?['display_name'] ?? '',

        'job_city':
            job['location']?['area'] != null &&
                    (job['location']['area'] as List).isNotEmpty
                ? job['location']['area'].last
                : '',

        'job_country': '',

        'job_employment_type': '',

        'job_description':
            job['description'] ?? '',

        'job_apply_link':
            job['redirect_url'] ?? '',

        'job_min_salary':
            job['salary_min'] ?? 0,

        'job_max_salary':
            job['salary_max'] ?? 0,
      },
    ).toList();
  }


  Future<List<dynamic>> getJobDetail(
     String id,
  ) async {

    try {
      //final stopwatch = Stopwatch()..start();
      final response = await DioClient.dio.get(
        '/job-details',
        queryParameters: {
          'job_id': id,
        },
      );

      //print(response.data);
    //   stopwatch.stop();

    // print(' API: ${stopwatch.elapsedMilliseconds} ms');
      return response.data['data'];
    } catch (e) {
      print(e);
    }

    return [];
  }

}