import 'package:dio/dio.dart';
import 'package:job_finder_app/core/network/dio_client.dart';

class JobDatasource {
  Future<List<dynamic>> getJobs({
    required String query,
    int page = 1,
  }) async {
    
    
    try{
      final response = await DioClient.jobDio.get(
      '/job-board-api',
      queryParameters: {
        'page': page,
      },
    );
    final List jobs = response.data['data'];
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
  catch(e){
   // print(e);
    return [];
  }
    }

  // ✅ រក្សាទុក ឬលុបការងារ
  Future<Response> saveJob({
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await DioClient.authDio.post(
        '/saved-jobs/toggle',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json', // បន្ថែមដើម្បីទទួលទិន្នន័យជា JSON
          },
        ),
      );
    } on DioException catch (e) {
      rethrow; // បញ្ជូនកំហុសទៅកាន់ Controller ដើម្បីបង្ហាញសារ
    }
  }

  // ✅ ទាញយកបញ្ជីការងារដែលបានរក្សាទុក
  Future<Response> getSavedJobs({
    required String token,
  }) async {
    try {
      return await DioClient.authDio.get(
        '/saved-jobs',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      rethrow;
    }
  }

  // ✅ លុបការងារចេញពីបញ្ជី
  Future<Response> deleteSaveJob({
    required String token,
    required String id, // ប្តូរឈ្មោះពី jobId ទៅ id ដើម្បីត្រូវគ្នានឹងផ្លូវ API
    }) async {
      try {
        return await DioClient.authDio.delete(
          '/saved-jobs/$id',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ),
        );
      } on DioException catch (e) {
        rethrow;
      }
    }
  
}