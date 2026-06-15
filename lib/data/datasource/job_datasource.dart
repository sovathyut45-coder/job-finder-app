import 'package:job_finder_app/core/network/dio_client.dart';

class JobDatasource {
Future<List<dynamic>> getJobs({
  required String query,
  int page = 1,
  int numPages = 1,
}) async {
  //final stopwatch = Stopwatch()..start();
  final response = await DioClient.dio.get(
    '/search',
    queryParameters: {
      'query': query,
      'page': page,
      'num_pages': numPages,
    },
  );

    // stopwatch.stop();

    // print('Detail API: ${stopwatch.elapsedMilliseconds} ms');
  
  return response.data['data'];
  
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