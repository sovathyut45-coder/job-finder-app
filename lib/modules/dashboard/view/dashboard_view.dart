import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/ApplyJob/view/applied_job_view.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:job_finder_app/modules/home/view/home_view.dart';
import 'package:job_finder_app/modules/profile/view/profile_view.dart';
import 'package:job_finder_app/modules/save_job/view/saved_jobs_view.dart';

class DashboardView extends GetView<DashboardController>{
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeView(),
      SavedJobsView(),
      AppliedJobView(),
      ProfileView(),
    ];
    final List<String> titles = [
      'home'.tr,
      'saved_jobs'.tr,
      'Applied Jobs'.tr,
      'profile'.tr,
    ];

    //print('Dashboard Build');
    
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          title: Text(
            titles[controller.currentIndex.value],
          ),
          actions: [
            GetX<ThemeController>(
              builder: (theme) {
                return IconButton(
                  icon: Icon(
                    theme.isDark.value
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: () {
                    theme.toggleTheme();
                  },
                );
              },
            ),

            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Get.toNamed(
                  AppRoutes.setting,
                );
              },
            ),
          ],
        ),
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'saved_jobs'.tr,
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Applied Jobs'.tr,
            ),

            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'profile'.tr,
            // )
          ],
        ),
      )
    );
    
  }
}