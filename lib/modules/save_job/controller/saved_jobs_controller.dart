import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/model/save_job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';

class SavedJobsController extends GetxController {
  final JobRepository repository;

  SavedJobsController(this.repository);

  final AuthService authService = Get.find<AuthService>();
  final AuthController authController = Get.find<AuthController>();
  final GetStorage box = GetStorage();

  RxBool isLoading = false.obs;
  RxList<SavedJobModel> savedJobs = <SavedJobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSavedJobs();
  }

  Future<void> toggleSavedJob(JobModel job) async {
    try {
      isLoading.value = true;

      // ពិនិត្យថាមានថូខឹនឬអត់
      if (authService.token == null || authService.token!.isEmpty) {
        throw 'សូមចូលប្រើប្រាស់ជាមុនសិន';
      }

      final response = await repository.saveJob(
        token: authService.token!,
        data: {
          'job_id': job.jobId,
          'title': job.jobTitle,
          'company': job.employerName,
          'location': job.jobLocation,
          //'job_type': job.employmentType ,
          'logo': job.employerLogo,
          'url': job.applyLink,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getSavedJobs(); 
        _updateDashboardStats();
      } else {
        throw 'មិនអាចរក្សាទុកបាន (កូដ: ${response.statusCode})';
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      Get.snackbar('កំហុស', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSavedJobs() async {
    try {
      isLoading.value = true;

      if (authService.token == null || authService.token!.isEmpty) {
        savedJobs.clear();
        throw 'សូមចូលប្រើប្រាស់ដើម្បីមើលការងារដែលបានរក្សាទុក';
      }

      final response = await repository.getSavedJobs(token: authService.token!);

      if (response.statusCode == 200) {
        final List jobs = response.data['saved_jobs'] ?? [];
        savedJobs.assignAll(
          jobs.map((json) => SavedJobModel.fromJson(json)).toList(),
        );
      } else {
        throw 'មិនអាចទាញយកទិន្នន័យបាន';
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      savedJobs.clear();
      Get.snackbar('កំហុស', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeSavedJob(SavedJobModel job) async {
    try {
      isLoading.value = true;

      if (authService.token == null || authService.token!.isEmpty) {
        throw 'សូមចូលប្រើប្រាស់ជាមុនសិន';
      }

      final response = await repository.deleteSaveJob(
        token: authService.token!,
        id: job.id.toString(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        savedJobs.removeWhere((item) => item.id.toString() == job.id.toString());
        Get.snackbar(
          'បានលុបបាន',
          'ការរក្សាទុកបានលុបដោយជោគជ័យ',
          snackPosition: SnackPosition.TOP,
        );
        _updateDashboardStats();
      } else {
        throw 'មិនអាចលុបបាន (កូដ: ${response.statusCode})';
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      Get.snackbar('កំហុស', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  bool isSaved(String jobId) {
    return savedJobs.any((job) => job.jobId == jobId);
  }

  void _handleDioError(DioException e) {
    String message;
    switch (e.response?.statusCode) {
      case 401:
        message = 'ការចូលប្រើប្រាស់អស់សុពលភាព សូមចូលម្តងទៀត';
        authController.logout();
        break;
      case 403:
        message = 'អ្នកគ្មានសិទ្ធិធ្វើសកម្មភាពនេះ';
        break;
      case 404:
        message = 'រកមិនឃើញទិន្នន័យ ឬផ្លូវមិនត្រឹមត្រូវ';
        break;
      case 500:
        message = 'មានបញ្ហានៅលើម៉ាស៊ីនបម្រើ សូមព្យាយាមម្តងទៀត';
        break;
      default:
        message = e.message ?? 'មានកំហុសក្នុងការតភ្ជាប់';
    }
    Get.snackbar('កំហុស', message, snackPosition: SnackPosition.BOTTOM);
  }

  /// 🔄 ធ្វើបច្ចុប្បន្នភាពស្ថិតិនៅផ្ទាំងគ្រប់គ្រង
  void _updateDashboardStats() {
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().loadStats();
      }
    });
  }
}