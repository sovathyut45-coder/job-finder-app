import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/modules/RecentJob/recent_jobs_controller.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';

class SettingController extends GetxController {
  final box = GetStorage();

  Future<void> clearSearchHistory(BuildContext context) async {
    box.remove('search_history');

      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text(
              'Search history cleared',
              style: TextStyle(color: Colors.white), // Explicit text contrast
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 1),
            backgroundColor: Get.theme.snackBarTheme.backgroundColor ?? Colors.grey[800],
            elevation: 6,
            clipBehavior: Clip.antiAlias,
          ),
        );

    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }

  Future<void> clearRecentJobs(BuildContext context) async {
      box.remove('recent_jobs');
  
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: const Text(
          'Recent jobs cleared',
          style: TextStyle(color: Colors.white), // Explicit text contrast
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor ?? Colors.grey[800],
        elevation: 6,
        clipBehavior: Clip.antiAlias,
      ),
    );
      await Future.microtask(() {
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>()
              .loadStats();
        }
        if(Get.isRegistered<RecentJobsController>()){
          Get.find<RecentJobsController>().loadRecentJobs();
          
        }
      });
      return; // Ensure the method completes with a return
  }

Future<void> showClearDialog({
  required String title,
  required Future<void> Function() onConfirm,
}) async {
  final result = await showDialog<bool>(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          'the_action_cannot_be_undone'.tr,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'cancel'.tr,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'clear'.tr,
            ),
          ),
        ],
      );
    },
  );

  if (result == true) {
    await onConfirm();
  }
}
}