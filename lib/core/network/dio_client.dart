
import 'package:dio/dio.dart';
import 'package:job_finder_app/core/constants/api_constants.dart';

class DioClient {
  static final Dio jobDio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.jobApi,
      
    ),
  );
  static final Dio authDio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.authApi,
      headers: {
        'Accept': 'application/json',
      }
    ),
  );
}