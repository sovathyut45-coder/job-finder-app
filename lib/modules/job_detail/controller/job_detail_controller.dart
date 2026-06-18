import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/RecentJob/recent_jobs_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailController extends GetxController {
  final JobRepository repository;

  JobDetailController(this.repository);

  Rxn<JobModel> job = Rxn<JobModel>();
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if(arguments is JobModel){
      job.value = arguments;
      addRecentJob(job.value!);

    }else{
      Get.snackbar(
        'Error',
        'Invalid Job Data'
      );
    }

  }

  void addRecentJob(JobModel job) {
  final box = GetStorage();

  List list =
      box.read('recent_jobs') ?? [];

  list.removeWhere(
    (e) => e['job_id'] == job.jobId,
  );

  list.insert(
    0,
    job.toJson(),
  );

  if (list.length > 10) {
    list = list.take(10).toList();
  }

  box.write(
    'recent_jobs',
    list,
  );

  }


  Future<void> applyJob(String url) async{
    if(url.isEmpty){
      Get.snackbar(
        'Error',
        'Application link not available'
      );
      return;
    }
    final uri = Uri.parse(url);
    if(await canLaunchUrl(uri)){
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      
    }else{
      Get.snackbar(
        'Error',
        'Cannot open application link'
      );
    }
  }
}