import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/data/model/applied_job_model.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AppliedJobsController extends GetxController {
  final box = GetStorage();
  final JobRepository repository;
  AppliedJobsController(this.repository);

  RxList<AppliedJobModel> appliedJobs = <AppliedJobModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final AuthService authService = Get.find<AuthService>();


  @override
  void onInit() {
    super.onInit();
    getAppliedJob();
    
  }

  Future<void> updateStatus(int id, String status) async {
    try {
      isLoading.value = true;

      if (authService.token == null || authService.token!.isEmpty) {
        throw 'សូមចូលប្រើប្រាស់ជាមុនសិន';
      }

      final response = await repository.updateStatus(
        token: authService.token!,
        data: {
          'status': status,
        },
        id: id,
      );

      if (response.statusCode == 200) {
        await getAppliedJob ();
      } else {
        throw 'មិនអាច Update Status បាន';
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Error',
        e.response?.data['message'] ?? e.message ?? 'Unknown error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNote(int id, String note) async {
    try {
      isLoading.value = true;

      if (authService.token == null || authService.token!.isEmpty) {
        throw 'សូមចូលប្រើប្រាស់ជាមុនសិន';
      }

      final response = await repository.updateNote(
        token: authService.token!,
        data: {'notes': note},
        id: id,
      );

      if (response.statusCode == 200) {
        await getAppliedJob();
      } else {
        throw 'មិនអាច Update Note បាន';
      }
    }on DioException catch(e){
      Get.snackbar(
        'Error',
        e.response?.data['message'] ?? e.message ?? 'Unknown error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
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

  Future<void> appliedJob(JobModel job) async {
    try{
      isLoading.value = true;
      if(authService.token == null || authService.token!.isEmpty){
        throw 'សូមចូលប្រើប្រាស់ជាមុនសិន';
      }
      final response = await repository.applyJob(
        token: authService.token!,
        data: {
          'job_id': job.jobId,
          'title': job.jobTitle,
          'company': job.employerName,
          'location': job.jobLocation,
          'logo': job.employerLogo,
          'url': job.applyLink,
          'notes': job.notes,
        },
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        await getAppliedJob();
        Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>()
              .loadStats();
        }
      });
      
      }else{
        throw 'មិនអាចរក្សាទុកបាន (កូដ: ${response.statusCode})';
      }
    }on DioException catch (e) {
      print(e);
    } catch (e) {
      Get.snackbar('កំហុស', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  
  }

  Future<void> getAppliedJob()async{
    try{
      isLoading.value = true;
      if(authService.token == null || authService.token!.isEmpty){
        throw 'សូមចូលប្រើប្រាស់ជាមុនសិន';
      }
      final response = await repository.getAppliedJobs(
        token: authService.token!,
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        final List job = response.data['applied_jobs'] ?? [];
        appliedJobs.assignAll(
          job.map((e) => AppliedJobModel.fromJson(e)).toList(),
        );
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().loadStats();
          //Get.find<DashboardController>().loadApplicationStats();
        }
      }else{
        throw 'មិនអាចរក្សាទុកបាន (កូដ: ${response.statusCode})';
      }
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      Get.snackbar('កំហុស', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeAppliedJob(AppliedJobModel job)async{
    try{
      isLoading.value = true;
      if(authService.token == null || authService.token!.isEmpty){
        throw 'សូមចូលប្រើប្រាស់ជាមុនសិន';
      }
      final response = await repository.deleteAppliedJob(
        token: authService.token!,
        id: job.id.toString(),
      );

      if(response.statusCode == 200 || response.statusCode == 204){
        appliedJobs.removeWhere((item) => item.id.toString() == job.id.toString());
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().loadStats();
          //Get.find<DashboardController>().loadApplicationStats();
        }
        Get.snackbar(
          'បានលុបបាន',
          'ការរក្សាទុកបានលុបដោយជោគជ័យ',
          snackPosition: SnackPosition.TOP,
        );
      }else{
        throw 'មិនអាចលុបបាន (កូដ: ${response.statusCode})';
      }
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      Get.snackbar('កំហុស', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearAppliedJob()async{
    try{
      isLoading.value = true;
      final response = await repository.clearAppliedJob(
        token: authService.token!
      );

      if(response.statusCode == 200){
        appliedJobs.clear();
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().loadStats();
          //Get.find<DashboardController>().loadApplicationStats();
        }
        Get.snackbar(
          'បានលុបបាន',
          'ការរក្សាទុកបានលុបដោយជោគជ័យ',
          snackPosition: SnackPosition.TOP,
        );
      }else{
        throw 'មិនអាចលុបបាន (កូដ: ${response.statusCode})';
      }
    }catch(e){
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }finally{
      isLoading.value = false;
    }
  }
}