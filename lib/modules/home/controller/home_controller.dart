import 'package:get/get.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';

class HomeController extends GetxController {
  final JobRepository repository;

  HomeController(this.repository);

  final isLoading = false.obs;

  final jobs = <JobModel>[].obs;

  final positions = [
    'Business Development',
    'Sales',
    'Design',
    'IT',
    'Operations',
    'Finance',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchPopularJobs();
  }

  Future<void> fetchPopularJobs() async {
    try {
      isLoading.value = true;

      final result = await repository.getJobs(
        query: 'Marketing',
        page: 1,
      );

      jobs.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshJobs() async {
    await fetchPopularJobs();
  }
}