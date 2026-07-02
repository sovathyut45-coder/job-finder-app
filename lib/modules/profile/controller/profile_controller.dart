
import 'package:get/get.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class ProfileController extends GetxController {

  final AuthController authController =
      Get.find<AuthController>();

  final AuthService authService =
      Get.find<AuthService>();

  void logout() {

    authController.logout();

    authController.user.value = null;

    Get.offAllNamed(
      AppRoutes.login,
    );
  }

  void openEditProfile() {

  final authController =
      Get.find<AuthController>();

  authController.editNameController.text =
      authController.user.value?.name ?? '';

  authController.editEmailController.text =
      authController.user.value?.email ?? '';

  Get.toNamed(
    AppRoutes.editProfile,
  );
}
}