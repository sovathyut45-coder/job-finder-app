import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/RecentJob/recent_jobs_controller.dart';


class JobDetailController extends GetxController {
  final JobRepository repository;

  JobDetailController(this.repository);
  Rxn<JobModel> job = Rxn<JobModel>();
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  final box = GetStorage();
 

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if(arguments is JobModel){
      job.value = arguments;
      Future.microtask(() {
        Get.find<RecentJobsController>()
            .addRecentJob(job.value!);
        Get.find<AppliedJobsController>();
      });

    }else{
      Get.snackbar(
        'Error',
        'Invalid Job Data'
      );
    }

  }
}