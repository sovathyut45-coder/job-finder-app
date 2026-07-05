import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/RecentJob/recent_jobs_controller.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

class SettingController extends GetxController {
  final box = GetStorage();

  void clearSearchHistory() {
    box.remove('search_history');

    Get.snackbar(
      'Success',
      'Search history cleared',
    );
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }

  void clearRecentJobs() {
    box.remove('recent_jobs');

    Get.snackbar(
      'Success',
      'Recent jobs cleared',
    );
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
      if(Get.isRegistered<RecentJobsController>()){
        Get.find<RecentJobsController>().loadRecentJobs();
        
      }
    });
  }

  void clearSavedJobs() {
    box.remove('save_jobs');

    Get.snackbar(
      'Success',
      'Saved jobs cleared',
    );
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
      if(Get.isRegistered<SavedJobsController>()){
        Get.find<SavedJobsController>().getSavedJobs();
      }
    });
  }

  void clearAppliedJobs() {
    box.remove('applied_jobs');

    Get.snackbar(
      'Success',
      'Applied jobs cleared',
    );
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
      if(Get.isRegistered<AppliedJobsController>()){
        Get.find<AppliedJobsController>().getAppliedJob();
      }
    });
  }

  Future<void> showClearDialog({
  required String title,
  required VoidCallback onConfirm,
}) async {
  final result = await Get.dialog<bool>(
    AlertDialog(
      title: Text(title),
      content: const Text(
        'This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text('Clear'),
        ),
      ],
    ),
  );

  if (result == true) {
    onConfirm();
  }
}
}