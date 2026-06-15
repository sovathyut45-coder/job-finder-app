import 'package:get/get.dart';
import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:job_finder_app/modules/home/controller/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<JobDatasource>(
      () => JobDatasource(),
    );

    Get.lazyPut<JobRepository>(
      () => JobRepository(
        Get.find<JobDatasource>(),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<JobRepository>(),
      ),
    );

    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}