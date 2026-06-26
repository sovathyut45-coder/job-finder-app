// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:job_finder_app/modules/job_detail/controller/job_detail_controller.dart';
// import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

// class JobDetailView extends GetView<JobDetailController> {
//   const JobDetailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final saveController = Get.find<SavedJobsController>();
    
//     return Scaffold(
//       appBar: AppBar(
        
//         title: Obx(() {
//           final job = controller.job.value;
//           if (job == null) {
//             return const Text('Job Detail');
//           }

//           final isSaved =
//               saveController.isSaved(job.jobId);

//           return Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   job.jobTitle,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   isSaved
//                       ? Icons.favorite
//                       : Icons.favorite_border,
//                 ),
//                 onPressed: () {
//                   if (isSaved) {
//                     saveController.removeJob(
//                       job.jobId,
//                     );
//                   } else {
//                     saveController.saveJob(
//                       job,
//                     );
//                   }
//                 },
//               ),
//             ],
//           );
//         }),
//       ),
        
//       body: Obx(() {
//         // Show loading indicator
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // Show error message
//         if (controller.error.value.isNotEmpty) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Text(
//                 'Error: ${controller.error.value}',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             ),
//           );
//         }

//         // Show message if no job data
//         final jobData = controller.job.value;
//         if (jobData == null) {
//           return const Center(child: Text('No job details available'));
//         }

//         // Main content when data is ready
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 40,
//                   child: ClipOval(
//                     child: Image.network(
//                       jobData.employerLogo,
//                       filterQuality: FilterQuality.high,
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) =>
//                           const Icon(Icons.business, size: 40),
                          
//                     ),
//                   ),
//                 )
//               ),

//               const SizedBox(height: 20),

//               Text(
//                 jobData.jobTitle,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 8),
//               Text("Company: ${jobData.employerName}"),
//               Text("Location: ${jobData.jobLocation}"),

//               const SizedBox(height: 16),
//               if (jobData.employmentType.isNotEmpty)
//               Chip(
//                 label: Text(jobData.employmentType),
//               ),

//               const SizedBox(height: 16),
              
//               const SizedBox(height: 4),
//               if (jobData.minSalary > 0 || jobData.maxSalary > 0)
//                 Text(
//                   'Salary: ${jobData.minSalary.toStringAsFixed(2)} - ${jobData.maxSalary.toStringAsFixed(2)}',
//                   style: Theme.of(context).textTheme.titleLarge,
//               ),

//               const SizedBox(height: 20),
//               Text(
//                 'Description',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               const SizedBox(height: 10),
//               Html(data: jobData.description),

//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     controller.applyJob(
//                       jobData.applyLink,
//                     );
//                   },
//                   icon: const Icon(Icons.open_in_new),
//                   label: const Text(
//                     'Apply Now',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
      
//     );
    
//   }
// }

//===================================== Version 2 =================================================

// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'package:job_finder_app/modules/job_detail/controller/job_detail_controller.dart';
// import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

// class JobDetailView extends GetView<JobDetailController> {
//   const JobDetailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final savedController =
//         Get.find<SavedJobsController>();

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           'Job Details',
//         ),
//         actions: [
//           Obx(() {
//             final job = controller.job.value;

//             if (job == null) {
//               return const SizedBox();
//             }

//             final isSaved =
//                 savedController.isSaved(
//               job.jobId,
//             );

//             return IconButton(
//               onPressed: () {
//                 if (isSaved) {
//                   savedController.removeJob(
//                     job.jobId,
//                   );
//                 } else {
//                   savedController.saveJob(
//                     job,
//                   );
//                 }
//               },
//               icon: Icon(
//                 isSaved
//                     ? Icons.favorite
//                     : Icons.favorite_border,
//               ),
//             );
//           }),
//         ],
//       ),
//       body: Obx(
//         () {
//           if (controller.isLoading.value) {
//             return const Center(
//               child:
//                   CircularProgressIndicator(),
//             );
//           }

//           if (controller
//               .error.value.isNotEmpty) {
//             return Center(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.all(
//                   24,
//                 ),
//                 child: Text(
//                   controller.error.value,
//                   textAlign:
//                       TextAlign.center,
//                 ),
//               ),
//             );
//           }

//           final job =
//               controller.job.value;

//           if (job == null) {
//             return const Center(
//               child: Text(
//                 'No job details available',
//               ),
//             );
//           }

//           return SingleChildScrollView(
//             padding:
//                 const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [

//                 /// HEADER
//                 Card(
//                   elevation: 2,
//                   shape:
//                       RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.circular(
//                       16,
//                     ),
//                   ),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.all(
//                       20,
//                     ),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 35,
//                           child:
//                               job.employerLogo
//                                       .isNotEmpty
//                                   ? ClipOval(
//                                       child:
//                                           Image.network(
//                                         job
//                                             .employerLogo,
//                                         width:
//                                             70,
//                                         height:
//                                             70,
//                                         fit: BoxFit
//                                             .cover,
//                                       ),
//                                     )
//                                   : const Icon(
//                                       Icons
//                                           .business,
//                                       size:
//                                           30,
//                                     ),
//                         ),

//                         const SizedBox(
//                           width: 16,
//                         ),

//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment
//                                     .start,
//                             children: [
//                               Text(
//                                 job.jobTitle,
//                                 style:
//                                     const TextStyle(
//                                   fontSize:
//                                       20,
//                                   fontWeight:
//                                       FontWeight
//                                           .bold,
//                                 ),
//                               ),

//                               const SizedBox(
//                                 height:
//                                     8,
//                               ),

//                               Text(
//                                 job
//                                     .employerName,
//                                 style:
//                                     TextStyle(
//                                   color: Colors
//                                       .grey
//                                       .shade700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 /// JOB INFO
//                 const Text(
//                   'Job Information',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight:
//                         FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 12,
//                 ),

//                 Card(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.all(
//                       16,
//                     ),
//                     child: Column(
//                       children: [

//                         Row(
//                           children: [
//                             const Icon(
//                               Icons
//                                   .location_on,
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 job.jobLocation,
//                               ),
//                             ),
//                           ],
//                         ),

//                         const Divider(),

//                         if (job
//                             .employmentType
//                             .isNotEmpty)
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.work,
//                               ),
//                               const SizedBox(
//                                 width:
//                                     8,
//                               ),
//                               Expanded(
//                                 child:
//                                     Text(
//                                   job
//                                       .employmentType,
//                                 ),
//                               ),
//                             ],
//                           ),

//                         if (job
//                             .employmentType
//                             .isNotEmpty)
//                           const Divider(),

//                         if (job
//                                 .minSalary >
//                             0)
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons
//                                     .payments,
//                               ),
//                               const SizedBox(
//                                 width:
//                                     8,
//                               ),
//                               Expanded(
//                                 child:
//                                     Text(
//                                   '\$${job.minSalary} - \$${job.maxSalary}',
//                                 ),
//                               ),
//                             ],
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 24,
//                 ),

//                 /// DESCRIPTION
//                 const Text(
//                   'Job Description',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight:
//                         FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 12,
//                 ),

//                 Card(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.all(
//                       12,
//                     ),
//                     child: Html(
//                       data:
//                           job.description,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 30,
//                 ),

//                 /// APPLY BUTTON
//                 SizedBox(
//                   width:
//                       double.infinity,
//                   height: 55,
//                   child:
//                       ElevatedButton.icon(
//                     onPressed: () {
//                       controller
//                           .applyJob(
//                         job.applyLink,
//                       );
//                     },
//                     icon: const Icon(
//                       Icons
//                           .open_in_new,
//                     ),
//                     label: const Text(
//                       'Apply Now',
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// ========================================= version 3 ======================================================

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/job_detail/controller/job_detail_controller.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';
import 'package:share_plus/share_plus.dart';

class JobDetailView extends GetView<JobDetailController> {
  const JobDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final savedController = Get.find<SavedJobsController>();
    final theme = Get.find<ThemeController>();
    final isDark = theme.isDark.value;
    final appliedcontroller = Get.find<AppliedJobsController>();

    // Get theme-aware colors
    final primaryColor = Theme.of(context).primaryColor;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardTheme.color ?? Colors.white;
    final textPrimary = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B);
    final textSecondary = Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF64748B);
    final dividerColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
    const accentColor = Color(0xFFFF6B6B);

    return Scaffold(
      backgroundColor: scaffoldBg,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,

          title: Text(
            'job_details'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          actions: [
            Obx(() {
              final job = controller.job.value;
              if (job == null) return const SizedBox();

              final isSaved = savedController.isSaved(job.jobId);

              return IconButton(
                tooltip: isSaved ? 'remove_from_favorites'.tr : 'save_jobs'.tr,
                onPressed: () {
                  if (isSaved) {
                    savedController.removeJob(job.jobId);
                  } else {
                    savedController.saveJob(job);

                    Get.snackbar(
                      'success'.tr,
                      'Added to favorites'.tr,
                      duration: const Duration(seconds: 2),
                      backgroundColor: accentColor,
                      colorText: Colors.white,
                    );

                    // Get.showSnackbar(
                    //   GetSnackBar(
                    //     message:
                    //         'Added to favorites',
                    //     duration:
                    //         const Duration(seconds: 2),
                    //   ),
                    // );
                  }
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    isSaved
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    key: ValueKey(isSaved),
                    color: isSaved ? accentColor : Colors.white,
                    size: 24,
                  ),
                ),
              );
            }),

            Obx(
              () => IconButton(
                tooltip: theme.isDark.value
                    ? 'light_mode'.tr
                    : 'dark_mode'.tr,
                onPressed: theme.toggleTheme,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    theme.isDark.value
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    key: ValueKey(theme.isDark.value),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

            Obx(() {
              final job = controller.job.value;

              return IconButton(
                tooltip: 'share'.tr,
                onPressed: () async {
                  if (job == null) return;

                  await SharePlus.instance.share(
                    ShareParams(text: '${job.jobTitle}\n${job.applyLink}'),
                  );

                  Get.snackbar(
                    "shared".tr,
                    "Link copied (Web doesn't support share sheet)".tr,
                  );
                },     
                icon: const Icon(
                  Icons.share_rounded,
                  size: 24,
                ),
              );
            }),

            const SizedBox(width: 8),
          ],
        ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
              
          }

          if (controller.error.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  controller.error.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textSecondary, fontSize: 16),
                ),
              ),
            );
          }

          final job = controller.job.value;
          if (job == null) {
            return Center(
              child: Text(
                'no_job_available'.tr,
                style: TextStyle(color: textSecondary, fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Card(
                  color: cardColor,
                  elevation: 2,
                  shadowColor: primaryColor.withOpacity(0.15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: primaryColor.withOpacity(0.1),
                          child: job.employerLogo.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    job.employerLogo,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.business, size: 30, color: primaryColor),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.jobTitle,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                job.employerName,
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// JOB INFO
                Text(
                  'job_information'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: cardColor,
                  elevation: 1,
                  shadowColor: primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: primaryColor),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                job.jobLocation,
                                style: TextStyle(color: textPrimary),
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 24, color: dividerColor),
                        if (job.employmentType.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.work, color: primaryColor),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  job.employmentType,
                                  style: TextStyle(color: textPrimary),
                                ),
                              ),
                            ],
                          ),
                        if (job.employmentType.isNotEmpty)
                          Divider(height: 24, color: dividerColor),
                        if (job.minSalary > 0)
                          Row(
                            children: [
                              Icon(Icons.payments, color: const Color(0xFF36BFFA)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '\$${job.minSalary} - \$${job.maxSalary}',
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                /// DESCRIPTION
                Text(
                  'job_description'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: cardColor,
                  elevation: 1,
                  shadowColor: primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Html(
                      data: job.description,
                      style: {
                        "body": Style(
                          color: textPrimary,
                          fontSize: FontSize(15),
                          margin: Margins.zero,
                        ),
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                /// APPLY BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shadowColor: primaryColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    // onPressed: () {
                    //   Get.dialog(
                    //     AlertDialog(
                    //       title: const Text(
                    //         'Apply Job',
                    //       ),
                    //       content: const Text(
                    //         'You are about to open the company application page.',
                    //       ),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () {
                    //             Get.back();
                    //           },
                    //           child: const Text(
                    //             'Cancel',
                    //           ),
                    //         ),
                    //         TextButton(
                    //           onPressed: () {
                    //             Get.back();

                    //             controller.applyJob(
                    //               job.applyLink,
                    //             );
                    //           },
                    //           child: const Text(
                    //             'Continue',
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // },

                    // Bottom Sheet
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                              ),

                              const SizedBox(height: 20),

                              const CircleAvatar(
                                radius: 32,
                                child: Icon(
                                  Icons.open_in_new,
                                  size: 32,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Text(
                                'apply_job'.tr,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),
                              
                              Text(
                                job.employerName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                job.jobTitle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'you_are_about_to_open_the_company_application_page'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                              ),

                              const SizedBox(height: 24),

                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        'cancel'.tr,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Get.back();
                                        await appliedcontroller
                                            .applyJob(
                                          job,
                                        );
                                        print(
                                            'Applied Registered = ${Get.isRegistered<AppliedJobsController>()}',
                                          );
                                        if(Get.isRegistered<AppliedJobsController>()){
                                          Get.find<AppliedJobsController>()
                                              .addAppliedJob(job);
                                        }
                                      },
                                      child: Text(
                                        'continue'.tr,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
                    
                    // onPressed: () => controller.applyJob(job.applyLink),
                    icon: const Icon(Icons.open_in_new),
                    label: Text(
                      'apply_now'.tr,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}