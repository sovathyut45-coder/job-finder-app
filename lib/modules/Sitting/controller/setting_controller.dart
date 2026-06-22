import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  final box = GetStorage();

  void clearSearchHistory() {
    box.remove('search_history');

    Get.snackbar(
      'Success',
      'Search history cleared',
    );
  }

  void clearRecentJobs() {
    box.remove('recent_jobs');

    Get.snackbar(
      'Success',
      'Recent jobs cleared',
    );
  }

  void clearSavedJobs() {
    box.remove('saved_jobs');

    Get.snackbar(
      'Success',
      'Saved jobs cleared',
    );
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