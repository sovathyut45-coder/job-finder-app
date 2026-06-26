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
                          title: const Text('Applied'),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'Applied',
                            );
                            Get.back();
                          },
                        ),

                        ListTile(
                          title: const Text('Interview'),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'Interview',
                            );
                            Get.back();
                          },
                        ),

                        ListTile(
                          title: const Text('Accepted'),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'Accepted',
                            );
                            Get.back();
                          },
                        ),

                        ListTile(
                          title: const Text('Rejected'),
                          onTap: () {
                            controller.updateStatus(
                              job.jobId,
                              'Rejected',
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
                    "Appplied on ${formatDate(job.appliedDate)}",
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
                                    title: const Text('Applied'),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'Applied',
                                      );
                                      Get.back();
                                    },
                                  ),

                                  ListTile(
                                    title: const Text('Interview'),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'Interview',
                                      );
                                      Get.back();
                                    },
                                  ),

                                  ListTile(
                                    title: const Text('Accepted'),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'Accepted',
                                      );
                                      Get.back();
                                    },
                                  ),

                                  ListTile(
                                    title: const Text('Rejected'),
                                    onTap: () {
                                      controller.updateStatus(
                                        job.jobId,
                                        'Rejected',
                                      );
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            )
                          );
                        },
                        child: Text('Update Status'.tr),
                      ),
                      const SizedBox(width: 8,),
                      IconButton(
                        onPressed: () => showNoteDialog(job),
                        icon: Icon(
                          Icons.note_add,
                          // color: accentColor,
                          size: 22,
                        ),
                        tooltip: 'Add Note'.tr,
                      ),
                      const SizedBox(width: 8,),
                      IconButton(
                        onPressed: () => controller.removeAppliedJob(job.jobId),
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: accentColor,
                          size: 22,
                        ),
                        tooltip: 'Remove job'.tr,
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
      title: 'Add Note',

      content: TextField(
        controller: noteController,
        maxLines: 4,
        decoration:
            const InputDecoration(
          hintText:
              'Enter note...',
        ),
      ),

      textConfirm: 'Save',

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