import 'package:get/get.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';

class HomeController extends GetxController {
  final JobRepository repository;

  HomeController(this.repository);

  final isLoading = false.obs;

  final jobs = <JobModel>[].obs;

  final positions = [
    'Flutter Developer',
    'Backend Developer',
    'UI/UX Designer',
    'Mobile Developer',
    'Data Analyst',
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
        query: 'Software Engineer',
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