import 'package:get/get.dart';
import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';

class AppliedJobsBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<JobDatasource>(
      () => JobDatasource()
    );
    Get.lazyPut<JobRepository>(
      () => JobRepository(Get.find<JobDatasource>())
    );

    Get.lazyPut<AppliedJobsController>(
      () => AppliedJobsController(Get.find<JobRepository>())
    );
  }
}