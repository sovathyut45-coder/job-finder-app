import 'package:dio/dio.dart';
import 'package:job_finder_app/core/network/dio_client.dart';

class AuthDatasource {

  // final Dio dio = Dio(
  //   BaseOptions(
  //     baseUrl: 'http://127.0.0.1:8000/api',
  //     headers: {
  //       'Accept': 'application/json',
  //     },
  //   ),
  // );

  Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await DioClient.authDio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await DioClient.authDio.post(
      '/login',
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response> profile(
    String token
  ) async{
    return await DioClient.authDio.get(
      '/profile',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}