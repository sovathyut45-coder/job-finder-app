import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/data/model/job_model.dart';

class SavedJobsController extends GetxController{
  final box = GetStorage();
  RxList<JobModel> savedJobs = <JobModel>[].obs; // Initialize as an empty list>

  @override
  void onInit() {
    super.onInit();
    savedJobs.value = box.read('save_jobs') ?? [];
  }

  void loadSavedJobs() {
    final data = box.read('save_jobs');
    if(data != null){
      savedJobs.value = List<Map<String, dynamic>>.from(data).map((job) => JobModel.fromJson(job)).toList(); // Convert to List<JobModel>>
    }
  }

  void saveJob(JobModel job){
    if(isSaved(job.jobId)) return;

    savedJobs.add(job);
    box.write('save_jobs', savedJobs.map((job) => job.toJson()).toList());
  }

  bool isSaved(String jobId){
    return savedJobs.any((job) => job.jobId == jobId);
  }

  void removeJob(String jobId){
    savedJobs.removeWhere((job) => job.jobId == jobId);
    box.write('save_jobs', savedJobs.map((job) => job.toJson()).toList());
  }
}