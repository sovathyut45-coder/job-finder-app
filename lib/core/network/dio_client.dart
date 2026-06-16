// import 'package:dio/dio.dart';
// import 'package:job_finder_app/core/constants/api_constants.dart';

// class DioClient {
//   static final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: ApiConstant.baseUrl,
//       headers: {
//         'Accept': 'application/json',
//       },
//     ),
//   )..interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           options.queryParameters.addAll({
//             'app_id': ApiConstant.appId,
//             'app_key': ApiConstant.appKey,
//           });

//           handler.next(options);
//         },
//       ),
//     );
// }


//                I Change to Arbeitnow Job Board API                            //
import 'package:dio/dio.dart';
import 'package:job_finder_app/core/constants/api_constants.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
    ),
  );
}