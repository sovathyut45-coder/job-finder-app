import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/ApplyJob/binding/applied_jobs_binding.dart';
import 'package:job_finder_app/modules/ApplyJob/view/applied_job_view.dart';
import 'package:job_finder_app/modules/Sitting/binding/setting_binding.dart';
import 'package:job_finder_app/modules/Sitting/view/setting_view.dart';
import 'package:job_finder_app/modules/dashboard/binding/dashboard_binding.dart';
import 'package:job_finder_app/modules/dashboard/view/dashboard_view.dart';
import 'package:job_finder_app/modules/home/binding/home_binding.dart';
import 'package:job_finder_app/modules/home/view/home_view.dart';
import 'package:job_finder_app/modules/job_detail/binding/job_detail_binding.dart';
import 'package:job_finder_app/modules/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/modules/search/binding/search_binding.dart';
import 'package:job_finder_app/modules/search/view/search_view.dart';
import 'package:job_finder_app/modules/splash/binding/splash_binding.dart';
import 'package:job_finder_app/modules/splash/view/splash_view.dart';

class AppPages {
  static const initial = AppRoutes.home;
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding()

    ),
    GetPage(
      name: AppRoutes.jobDetails,
      page: () => JobDetailView(),
      binding: JobDetailBinding()
    ),

    GetPage(
      name: AppRoutes.dashboard,
      page: ()=> DashboardView(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => SearchView(),
      binding: SearchBinding(),

    ),
    GetPage(
      name: AppRoutes.setting,
      page: ()=> SettingView(),
      binding: SettingBinding()
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.appliedJobs,
      page: () => AppliedJobView(),
    ),
  ];
}