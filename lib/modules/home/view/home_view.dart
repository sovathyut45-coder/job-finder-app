// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../core/routes/app_routes.dart';
// import '../controller/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => RefreshIndicator(
//         onRefresh: controller.refreshJobs,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             const SizedBox(height: 10),

//             const Text(
//               'Find Your Dream Job',
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 8),

//             Text(
//               'Discover opportunities that match your skills',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 16,
//               ),
//             ),

//             const SizedBox(height: 24),

//             InkWell(
//               onTap: () {
//                 Get.toNamed(
//                   AppRoutes.search,
//                 );
//               },
//               borderRadius:
//                   BorderRadius.circular(12),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius:
//                       BorderRadius.circular(12),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.search),
//                     SizedBox(width: 10),
//                     Text(
//                       'Search jobs...',
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             const Text(
//               'Popular Positions',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 12),

//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children:
//                   controller.positions.map(
//                 (position) {
//                   return ActionChip(
//                     label: Text(position),
//                     onPressed: () {
//                       Get.toNamed(
//                         AppRoutes.search,
//                         arguments: position,
//                       );
//                     },
//                   );
//                 },
//               ).toList(),
//             ),

//             const SizedBox(height: 30),

//             Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Popular Jobs',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Get.toNamed(
//                       AppRoutes.search,
//                       arguments:
//                           'Software Engineer',
//                     );
//                   },
//                   child: const Text(
//                     'See All',
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             if (controller.isLoading.value)
//               const Center(
//                 child: Padding(
//                   padding:
//                       EdgeInsets.all(32),
//                   child:
//                       CircularProgressIndicator(),
//                 ),
//               )
//             else if (controller.jobs.isEmpty)
//               const Padding(
//                 padding: EdgeInsets.all(24),
//                 child: Center(
//                   child: Text(
//                     'No jobs found',
//                   ),
//                 ),
//               )
//             else
//               ...controller.jobs
//                   .take(5)
//                   .map(
//                 (job) {
//                   return Card(
//                     elevation: 2,
//                     margin:
//                         const EdgeInsets.only(
//                       bottom: 12,
//                     ),
//                     shape:
//                         RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(
//                         12,
//                       ),
//                     ),
//                     child: InkWell(
//                       borderRadius:
//                           BorderRadius.circular(
//                         12,
//                       ),
//                       onTap: () {
//                         Get.toNamed(
//                           AppRoutes.jobDetails,
//                           arguments: job,
//                         );
//                       },
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.all(
//                           16,
//                         ),
//                         child: Row(
//                           crossAxisAlignment:
//                               CrossAxisAlignment
//                                   .start,
//                           children: [
//                             CircleAvatar(
//                               radius: 24,
//                               child: job
//                                       .employerLogo
//                                       .isEmpty
//                                   ? const Icon(
//                                       Icons.business,
//                                     )
//                                   : null,
//                             ),

//                             const SizedBox(
//                               width: 12,
//                             ),

//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment:
//                                     CrossAxisAlignment
//                                         .start,
//                                 children: [
//                                   Text(
//                                     job.jobTitle,
//                                     maxLines: 2,
//                                     overflow:
//                                         TextOverflow
//                                             .ellipsis,
//                                     style:
//                                         const TextStyle(
//                                       fontSize:
//                                           16,
//                                       fontWeight:
//                                           FontWeight
//                                               .bold,
//                                     ),
//                                   ),

//                                   const SizedBox(
//                                     height: 6,
//                                   ),

//                                   Text(
//                                     job.employerName,
//                                     style:
//                                         TextStyle(
//                                       color: Colors
//                                           .grey
//                                           .shade700,
//                                     ),
//                                   ),

//                                   const SizedBox(
//                                     height: 8,
//                                   ),

//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons
//                                             .location_on,
//                                         size: 16,
//                                       ),
//                                       const SizedBox(
//                                         width: 4,
//                                       ),
//                                       Expanded(
//                                         child:
//                                             Text(
//                                           job.jobLocation,
//                                           overflow:
//                                               TextOverflow
//                                                   .ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             const Icon(
//                               Icons
//                                   .arrow_forward_ios,
//                               size: 16,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// ======================================== Version 2 ======================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/widgets/job_card_skeleton.dart';
import 'package:job_finder_app/core/widgets/skeleton_loading.dart';
import 'package:job_finder_app/modules/RecentJob/recent_jobs_controller.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/Theme/theme_controller.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    final recentController = Get.find<RecentJobsController>();
    

    // Get theme-aware colors
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardTheme.color ?? Colors.white;
    final textPrimary = Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1E293B);
    final textSecondary = Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF64748B);
    final searchBg = isDark ? const Color(0xFF1E293B) : const Color(0xFFEFF4FB);
    const secondaryColor = Color(0xFF36BFFA);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(
        () => RefreshIndicator(
          color: primaryColor,
          onRefresh: controller.refreshJobs,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 10),

              Text(
                'find_your_dream_job'.tr,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'discover_opportunities_that_match_your_skills'.tr,
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 24),

              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: searchBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        'search_jobs...'.tr,
                        style: TextStyle(color: textSecondary),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'popular_positions'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.positions.map((position) {
                  return ActionChip(
                    label: Text(position, style: TextStyle(color: primaryColor)),
                    backgroundColor: primaryColor.withOpacity(0.08),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.search,
                        arguments: position,
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              Obx(() {
                if (recentController.recentJobs.isEmpty) {
                  return const SizedBox();
                }

                return Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                     Text(
                      'recent_views'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...recentController.recentJobs
                        .take(5)
                        .map((job) {
                      return Card(
                        margin:
                            const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.jobDetails,
                              arguments: job,
                            );
                          },

                          leading: CircleAvatar(
                            child: Icon(
                              Icons.history,
                            ),
                          ),

                          title: Text(
                            job.jobTitle,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                          ),

                          subtitle: Text(
                            job.employerName,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                          ),

                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),

              

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'popular_jobs'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.search,
                        arguments: 'Software Engineer',
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: primaryColor),
                    child: Text('see_all'.tr, style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (controller.isLoading.value)
                SkeletonLoading(
                  child: Column(
                    children: List.generate(
                      5,
                      (index) => const JobCardSkeleton(),
                    ),
                  ),
                )
              else if (controller.jobs.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'no_job_found'.tr,
                      style: TextStyle(color: textSecondary, fontSize: 16),
                    ),
                  ),
                )
              else
                ...controller.jobs.take(5).map((job) {
                  return Card(
                    color: cardColor,
                    elevation: 2,
                    shadowColor: primaryColor.withOpacity(0.12),
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.jobDetails,
                          arguments: job,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: primaryColor.withOpacity(0.1),
                              backgroundImage: job.employerLogo.isNotEmpty
                                  ? NetworkImage(job.employerLogo)
                                  : null,
                              child: job.employerLogo.isEmpty
                                  ? Icon(Icons.business, color: primaryColor)
                                  : null,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.jobTitle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: textPrimary,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    job.employerName,
                                    style: TextStyle(color: textSecondary),
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16, color: secondaryColor),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          job.jobLocation,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: textSecondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    children: [
                                      Chip(
                                        visualDensity: VisualDensity.compact,
                                        backgroundColor: primaryColor.withOpacity(0.08),
                                        label: Text(
                                          job.employmentType.isEmpty ? 'Available' : job.employmentType,
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Icon(Icons.arrow_forward_ios, size: 16, color: textSecondary),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}