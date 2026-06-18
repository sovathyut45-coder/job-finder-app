import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

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
            .map(
              (e) => JobModel.fromJson(e),
            )
            .toList();
  }

}