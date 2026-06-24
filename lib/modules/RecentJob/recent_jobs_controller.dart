import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';

import '../../data/model/job_model.dart';

class RecentJobsController extends GetxController {
  final box = GetStorage();

  final recentJobs = <JobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentJobs();
  }

  void loadRecentJobs() {
    final data =
        box.read('recent_jobs') ?? [];

    recentJobs.value =
        List<Map<String, dynamic>>.from(data)
            .map((e) => JobModel.fromJson(e)).toList();
  }

  void addRecentJob(JobModel job) {

    recentJobs.removeWhere(
      (e) => e.jobId == job.jobId,
    );

    recentJobs.insert(0, job);

    if (recentJobs.length > 3) {
      recentJobs.removeRange(
        3,
        recentJobs.length,
      );
    }

    box.write(
      'recent_jobs',
      recentJobs
          .map((e) => e.toJson())
          .toList(),
    );

    recentJobs.refresh();

    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }
}