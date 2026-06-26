import 'package:get/get.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';

class AppliedJobsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AppliedJobsController>(
      () => AppliedJobsController()
    );
  }
}