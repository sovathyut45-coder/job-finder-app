import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    print('SplashController onInit');

    Future.delayed(
      const Duration(seconds: 2),
      () {
        print('Navigate Dashboard');

        Get.offAllNamed(
          AppRoutes.dashboard,
        );
      },
    );
  }
}