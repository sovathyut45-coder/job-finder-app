import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';

class AppliedJobView extends GetView<AppliedJobsController> {
  const AppliedJobView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;

    // Get theme-aware colors
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardTheme.color ?? Colors.white;
    final textPrimary = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B);
    final textSecondary = Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF64748B);
    const accentColor = Color(0xFFFF6B6B);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(
        () => controller.appliedJobs.isEmpty
            ? _buildEmptyState(primaryColor, textSecondary)
            : _buildJobsList(primaryColor, cardColor, textPrimary, textSecondary, accentColor),
      ),
    );
  }

  Widget _buildEmptyState(Color primaryColor, Color textSecondary) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 80,
            color: textSecondary.withOpacity(0.4),
          ),
          const SizedBox(height: 20),
          Text(
            'No Applied Jobs'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'You have not applied for any jobs yet'.tr,
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildJobsList(
    Color primaryColor,
    Color cardColor,
    Color textPrimary,
    Color textSecondary,
    Color accentColor,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: controller.appliedJobs.length,
      itemBuilder: (context, index) {
        final job = controller.appliedJobs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(Get.find<ThemeController>().isDark.value ? 0.15 : 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              Get.toNamed(
                AppRoutes.jobDetails,
                arguments: job,
              );
            },
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              job.jobTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textPrimary, 
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                job.employerName,
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () => controller.removeAppliedJob(job.jobId),
              icon: Icon(
                Icons.delete_outline_rounded,
                color: accentColor,
                size: 22,
              ),
              tooltip: 'Remove job'.tr,
            ),
          ),
        );
      },
    );
  }
}