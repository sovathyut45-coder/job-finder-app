import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AppliedJobsController extends GetxController {
  final box = GetStorage();

  RxList<JobModel> appliedJobs =
     <JobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAppliedJobs();
  }

  void addAppliedJob(JobModel job) {
    appliedJobs.removeWhere(
      (e) => e.jobId == job.jobId,
    );

    //   final appliedJob = JobModel(
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
    //   appliedDate: DateTime.now().toIso8601String(),
    // );

    // OPTION 2
    final appliedJob = job.copyWith(
      appliedDate: DateTime.now().toIso8601String(),
      applicationStatus: 'Applied',
    );

    appliedJobs.insert(0,appliedJob);


      box.write(
        'applied_jobs',
        appliedJobs
            .map((e) => e.toJson())
            .toList(),
      );

    if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
  }


  void updateStatus(String jobId,String status) {
      final index = appliedJobs.indexWhere(
        (job) => job.jobId == jobId,
      );

      if (index == -1) return;

      appliedJobs[index] =
          appliedJobs[index].copyWith(
            applicationStatus: status,
          );

      appliedJobs.refresh();

      box.write(
        'applied_jobs',
        appliedJobs
            .map((e) => e.toJson())
            .toList(),
      );
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadApplicationStats();
      }
    }


  void updateNote(String jobId,String note) {
    final index =
        appliedJobs.indexWhere(
      (job) => job.jobId == jobId,
    );

    if (index == -1) return;

    appliedJobs[index] =
        appliedJobs[index].copyWith(
      notes: note,
    );

    appliedJobs.refresh();

    box.write(
      'applied_jobs',
      appliedJobs
          .map((e) => e.toJson())
          .toList(),
    );
  }


  Future<void> applyJob(JobModel job) async {
    if (job.applyLink.isEmpty) {
      Get.snackbar(
        'Error',
        'Application link not available',
      );
      return;
    }

    final uri = Uri.parse(
      job.applyLink,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Get.snackbar(
        'Error',
        'Cannot open application link',
      );
    }
  }

  void loadAppliedJobs() {
    final data = box.read('applied_jobs') ?? [];
    if(data != null){
      appliedJobs.value = List<Map<String, dynamic>>.from(data).map((job) => JobModel.fromJson(job)).toList(); // Convert to List<JobModel>>
    }
  }

  void removeAppliedJob(
    String jobId,
  ) {
    appliedJobs.removeWhere((job) => job.jobId == jobId);
    box.write('applied_jobs', appliedJobs.map((job) => job.toJson()).toList());
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }

  void clearAppliedJobs() {
    box.remove('applied_jobs');

    Get.snackbar(
      'Success',
      'Applied jobs cleared',
    );
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }
}