import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

class DashboardController extends GetxController{
  JobRepository repository;
  DashboardController(this.repository);
  final authService = Get.find<AuthService>();
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
  final pendingCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }
  
  void changeIndex(int index){
    currentIndex.value = index;
  }

  Future<void> loadStats() async {
  try {
    final response = await repository.getDashboardStats(
      token: authService.token!,
    );

    final data = response.data;

    savedCount.value = data['saved_jobs'];
    appliedCount.value = data['applied_jobs'];
    pendingCount.value = data['pending'];
    interviewCount.value = data['interview'];
    acceptedCount.value = data['accepted'];
    rejectedCount.value = data['rejected'];

    recentCount.value = (box.read('recent_jobs') ?? []).length;
    searchCount.value = (box.read('search_history') ?? []).length;

  } catch (e) {
    Get.snackbar('Error', e.toString());
  }
}

}