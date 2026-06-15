import 'package:dio/dio.dart';
import 'package:job_finder_app/core/constants/api_constants.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'X-RapidAPI-Key': ApiConstants.apiKey,
        'X-RapidAPI-Host' : 'jsearch.p.rapidapi.com'
      }
    )
  );
}