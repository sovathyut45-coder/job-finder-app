import 'package:get/get.dart';
import 'package:job_finder_app/modules/RecentJob/recent_jobs_controller.dart';

class RecentJobBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RecentJobsController>(
      () => RecentJobsController()
    );
  }
}