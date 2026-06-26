import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';

class SavedJobsController extends GetxController{
  final box = GetStorage();
  RxList<JobModel> savedJobs = <JobModel>[].obs; // Initialize as an empty list>

  @override
  void onInit() {
    super.onInit();
    loadSavedJobs();
  }

  void loadSavedJobs() {
    final data = box.read('save_jobs') ?? [];
    if(data != null){
      savedJobs.value = List<Map<String, dynamic>>.from(data).map((job) => JobModel.fromJson(job)).toList(); // Convert to List<JobModel>>
    }
  }

  void saveJob(JobModel job){
    if(isSaved(job.jobId)) return;

    // final savedJob = JobModel(
    //   jobId: job.jobId,
    //   jobTitle: job.jobTitle,
    //   jobCity: job.jobCity,
    //   jobCountry: job.jobCountry,
    //   employerName: job.employerName,
    //   employerLogo: job.employerLogo,
    //   jobLocation: job.jobLocation,
    //   employmentType: job.employmentType,
    //   description: job.description,
    //   applyLink: job.applyLink,
    //   minSalary: job.minSalary,
    //   maxSalary: job.maxSalary,
    //   savedDate: DateTime.now()
    //       .toIso8601String(),
    // );

    // OPTION 2
    final savedJob = job.copyWith(
      savedDate: DateTime.now().toIso8601String(),
    );
    savedJobs.add(savedJob);
    box.write('save_jobs', savedJobs.map((job) => job.toJson()).toList());
    // load dashboard stats
     Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }

  bool isSaved(String jobId){
    return savedJobs.any((job) => job.jobId == jobId);
  }

  void removeJob(String jobId){
    savedJobs.removeWhere((job) => job.jobId == jobId);
    box.write('save_jobs', savedJobs.map((job) => job.toJson()).toList());

     Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }
}