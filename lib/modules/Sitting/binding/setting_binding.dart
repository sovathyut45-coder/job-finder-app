import 'package:get/get.dart';
import 'package:job_finder_app/modules/Sitting/controller/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController()
    );
  }
}