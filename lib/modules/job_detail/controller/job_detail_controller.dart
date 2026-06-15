import 'package:get/get.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
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
    // Safely get and validate arguments
    final arguments = Get.arguments;
    if (arguments is String && arguments.isNotEmpty) {
      getJobDetail(arguments);
    } else {
      error.value = "Invalid or missing job ID";
    }
  }

  Future<void> getJobDetail(String id) async {
    try {
      isLoading.value = true;
      final data = await repository.getJobDetail(id);
      // Add safety check for empty/null list
      if (data.isNotEmpty) {
        job.value = data.first;
      } else {
        error.value = "Job not found";
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
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