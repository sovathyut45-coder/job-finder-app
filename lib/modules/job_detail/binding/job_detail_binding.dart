import 'package:get/get.dart';
import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/job_detail/controller/job_detail_controller.dart';

class JobDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<JobDatasource>(
      () => JobDatasource()
    );
    Get.lazyPut<JobRepository>(
      () => JobRepository(
        Get.find<JobDatasource>()
      )
    );
    Get.lazyPut<JobDetailController>(
      () => JobDetailController(
        Get.find<JobRepository>()
      )
    );
  }
}