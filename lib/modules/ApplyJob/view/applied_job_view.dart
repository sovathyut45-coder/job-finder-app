import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/data/model/job_model.dart';
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

  String formatDate(String date) {
    if (date.isEmpty) return '';

    return DateFormat(
      'dd MMM yyyy',
      Get.locale!.languageCode,
    ).format(
      DateTime.parse(date),
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
            'no_applied_jobs'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'you_have_no_applied_for_any_jobs_yet'.tr,
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

              onLongPress: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Wrap(
                      children: [
                        ListTile(
                          title: Text('applied'.tr),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'applied'.tr,
                            );
                            Get.back();
                          },
                        ),

                        ListTile(
                          title: Text('interview'.tr),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'interview'.tr,
                            );
                            Get.back();
                          },
                        ),

                        ListTile(
                          title: Text('accepted'.tr),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'accepted'.tr,
                            );
                            Get.back();
                          },
                        ),

                        ListTile(
                          title: Text('rejected'.tr),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'rejected'.tr,
                            );
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },


            //contentPadding: const EdgeInsets.all(16),
            title: Text(
              job.jobTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textPrimary, 
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    job.employerName,
                    style: TextStyle(
                      fontSize: 14,
                      color: textSecondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "Applied On: ${formatDate(job.appliedDate)}".tr,
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Chip(
                    label: Text(
                      "Status: ${job.applicationStatus}",
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                if (job.notes.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      job.notes,
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                  ),
                SizedBox(height: 8,),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           backgroundColor: cardColor,
                           foregroundColor: textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: textPrimary,
                              width: 0.5,
                            ), 
                          ),
                        ),
                        onPressed: (){
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Wrap(
                                children: [
                                  ListTile(
                                    title: Text('applied'.tr),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'applied'.tr,
                                      );
                                      Get.back();
                                    },
                                  ),

                                  ListTile(
                                    title: Text('interview'.tr),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'interview'.tr,
                                      );
                                      Get.back();
                                    },
                                  ),

                                  ListTile(
                                    title: Text('accepted'.tr),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'accepted'.tr,
                                      );
                                      Get.back();
                                    },
                                  ),

                                  ListTile(
                                    title: Text('rejected'.tr),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'rejected'.tr,
                                      );
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            )
                          );
                        },
                        child: Text('update_status'.tr),
                      ),
                      const SizedBox(width: 8,),
                      IconButton(
                        onPressed: () => showNoteDialog(job),
                        icon: Icon(
                          Icons.note_add,
                          // color: accentColor,
                          size: 22,
                        ),
                        tooltip: 'add_note'.tr,
                      ),
                      const SizedBox(width: 8,),
                      IconButton(
                        onPressed: () => controller.removeAppliedJob(job.jobId),
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: accentColor,
                          size: 22,
                        ),
                        tooltip: 'remove_job'.tr,
                      ),
                    ],
                  ),
                )
              ],
            ), 
          ),
        );
      },
    );
  }

  void showNoteDialog(JobModel job) {
    final noteController =
        TextEditingController(
      text: job.notes,
    );

    Get.defaultDialog(
      title: 'add_note'.tr,

      content: TextField(
        controller: noteController,
        maxLines: 4,
        decoration:
            InputDecoration(
          hintText:
              'enter_note...'.tr,
        ),
      ),

      textConfirm: 'save'.tr,

      onConfirm: () {
        controller.updateNote(
          job.jobId,
          noteController.text,
        );

        Get.back();
      },
    );
  }
}