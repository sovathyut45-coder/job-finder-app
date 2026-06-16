import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:job_finder_app/modules/home/controller/home_controller.dart';
import 'package:job_finder_app/modules/home/view/home_view.dart';
import 'package:job_finder_app/modules/profile/view/profile_view.dart';
import 'package:job_finder_app/modules/save_job/view/saved_jobs_view.dart';

class DashboardView extends GetView<DashboardController>{
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    //final homecon = Get.find<HomeController>();
    final pages = [
      HomeView(),
      SavedJobsView(),
      ProfileView(),
    ];
    final List<String> titles = [
      'Home',
      'Saved Jobs',
      'Profile',
    ];
    
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
          ],
        ),
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Saved Jobs',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),
      )
    );
    
  }
}