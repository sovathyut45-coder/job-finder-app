import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<JobDatasource>(
      () => JobDatasource()
    );

    Get.lazyPut<JobRepository>(
      ()=>JobRepository(
        Get.find<JobDatasource>()
      )
    );
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<JobRepository>()));
  }
}