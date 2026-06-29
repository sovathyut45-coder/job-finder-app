import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class ProfileController extends GetxController {

  final authController =
      Get.find<AuthController>();

}