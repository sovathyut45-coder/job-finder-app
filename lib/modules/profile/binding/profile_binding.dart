import 'package:get/get.dart';
import 'package:job_finder_app/modules/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}