import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class SplashController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();

  //   print('SPLASH INIT');

  //   Future.delayed(
  //     const Duration(seconds: 2),
  //     () async{

  //       final authService = Get.find<AuthService>();

  //       if (authService.isLoggedIn) {
  //          print('HAS TOKEN');
  //         final authController = Get.find<AuthController>();
  //         print('BEFORE PROFILE');
  //         await authController.getProfile();
  //          print('AFTER PROFILE');
  //         print(
  //         authController.user.value?.name,
  //       );
  //         Get.offAllNamed(
  //           AppRoutes.dashboard,
  //         );
  //       }
  //       else{
  //         Get.offAll(
  //           AppRoutes.login
  //         );
  //       }

        
  //     },
  //   );
  // }
  @override
void onInit() {
  super.onInit();

  Future.delayed(
    const Duration(seconds: 2),
    () async {

      final authService =
          Get.find<AuthService>();

      if (authService.isLoggedIn) {

        final authController =
            Get.find<AuthController>();

        await authController
            .getProfile();

        Get.offAllNamed(
          AppRoutes.dashboard,
        );
      }else{
        Get.offAllNamed(
          AppRoutes.login,
        );
      }
    },
  );
}
}