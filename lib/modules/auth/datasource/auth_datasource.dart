import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/core/network/dio_client.dart';

class AuthDatasource {

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

  Future<Response> logout(
    {required String token}
  )async{
    return await DioClient.authDio.post(
      '/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        }
      )
    );
    
  }

  Future<Response> forgotPassword({
    required Map<String, dynamic> data,
  }){
    return DioClient.authDio.post(
      '/forgot-password',
      data: data,
    );
  }

  Future<Response> changePassword({
    required String token,
    required Map<String, dynamic> data,
  }){
    return DioClient.authDio.put(
      '/change-password',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        }
      )
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

  Future<Response> updateProfile({
    required String token,
    required String name,
    required String email,
  }) {

    return DioClient.authDio.put(
      '/profile',
      data: {
        'name': name,
        'email': email,
      },
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
        },
      ),
    );
  }

  // Mobile only support

  // Future<Response> uploadAvatar({
  //   required String token,
  //   required String imagePath,
  // }) async {
  //   return DioClient.authDio.post(
  //     '/profile/avatar',
  //     data: FormData.fromMap({
  //       'avatar': await MultipartFile.fromFile(
  //         imagePath,
  //         filename: basename(imagePath),
  //       ),
  //     }),
  //     options: Options(
  //       headers: {
  //         'Authorization':
  //             'Bearer $token',
  //       },
  //     ),
  //   );
  // }

  // MOBILE and WEB Support

  Future<Response> uploadAvatar({
    required String token,
    required XFile file,
  }) async {

    final bytes =
        await file.readAsBytes();

    return DioClient.authDio.post(
      '/profile/avatar',
      data: FormData.fromMap({
        'avatar':
            MultipartFile.fromBytes(
          bytes,
          filename: file.name,
        ),
      }),
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
        },
      ),
    );
  }
}