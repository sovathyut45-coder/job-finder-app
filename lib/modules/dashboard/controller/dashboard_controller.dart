import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

class DashboardController extends GetxController{
  final currentIndex = 0.obs;
  final box = GetStorage();
  final savecontroller = Get.find<SavedJobsController>();
  final appliedcontroller = Get.find<AppliedJobsController>();

  final savedCount = 0.obs;
  final recentCount = 0.obs;
  final searchCount = 0.obs;
  final appliedCount = 0.obs;
  final interviewCount = 0.obs;
  final acceptedCount = 0.obs;
  final rejectedCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadStats();
    loadApplicationStats();
  }
  
  void changeIndex(int index){
    currentIndex.value = index;
  }

  void loadStats(){
    savedCount.value = savecontroller.savedJobs.length;
    recentCount.value = (box.read('recent_jobs') ?? []).length;
    searchCount.value = (box.read('search_history') ?? []).length;
    appliedCount.value = appliedcontroller.appliedJobs.length;
  }

  void loadApplicationStats() {

    final jobs = appliedcontroller.appliedJobs;

    appliedCount.value = jobs.length;

    interviewCount.value = jobs.where(
      (e) => e.status == 'Interview',
    ).length;

    acceptedCount.value = jobs.where(
      (e) => e.status == 'Accepted',
    ).length;

    rejectedCount.value = jobs.where(
      (e) => e.status == 'Rejected',
    ).length;
  }

}