import 'package:get/get.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/auth/binding/auth_binding.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';
import 'package:job_finder_app/translations/language/controller/language_controller.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {

    Get.put(
      ThemeController(),
      permanent: true,
    );
    Get.put(
      LanguageController(),
      permanent: true,
    );
    Get.put(
      AuthService(),
      permanent: true
    );

    AuthBinding().dependencies();

    Get.put(
      JobDatasource(),
      permanent: true
    );

    Get.put(
      JobRepository(Get.find<JobDatasource>()),
      permanent: true
    );

    Get.put(
      SavedJobsController(Get.find<JobRepository>()),
      permanent: true
    );
  }
}