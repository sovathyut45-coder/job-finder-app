import 'package:get/get.dart';
import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/ApplyJob/binding/applied_jobs_binding.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/RecentJob/binding/recent_job_binding.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';
import 'package:job_finder_app/modules/auth/repository/auth_repository.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:job_finder_app/modules/home/binding/home_binding.dart';
import 'package:job_finder_app/modules/profile/binding/profile_binding.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<JobDatasource>(
      () => JobDatasource(),
    );

    Get.lazyPut<JobRepository>(
      () => JobRepository(
        Get.find<JobDatasource>(),
      ),
    );

    HomeBinding().dependencies();

    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );

    RecentJobBinding().dependencies();

    Get.lazyPut<AppliedJobsController>(
      () => AppliedJobsController(),
      fenix: true
    );
    ProfileBinding().dependencies();
  }
}