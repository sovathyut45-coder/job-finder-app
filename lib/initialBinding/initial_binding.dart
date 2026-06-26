import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';
import 'package:job_finder_app/translations/language/controller/language_controller.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(
      SavedJobsController(),
      permanent: true
    );
    Get.put(
      ThemeController(),
      permanent: true,
    );
    Get.put(
      LanguageController(),
      permanent: true,
    );
    // Get.put(
    //   AppliedJobsController(),
    //   permanent: true
    // );
  }
}