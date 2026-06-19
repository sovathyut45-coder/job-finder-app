// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:job_finder_app/core/routes/app_routes.dart';
// import 'package:job_finder_app/modules/search/controller/search_job_controller.dart';

// class SearchView extends GetView<SearchJobController> {
//   const SearchView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Jobs'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               controller: controller.searchController,
//               onChanged: controller.onSearchChanged,
//               decoration: InputDecoration(
//                 hintText: 'Search jobs...',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   onPressed: controller.searchJobs,
//                   icon: const Icon(Icons.send),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onSubmitted: (_) {
//                 controller.searchJobs();
//               },
//             ),
//           ),

//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }

//               if (controller.jobs.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     'No jobs found',
//                   ),
//                 );
//               }

//               return RefreshIndicator(
//                 onRefresh: controller.refreshJobs,
//                 child: ListView.builder(
//                   physics:
//                       const AlwaysScrollableScrollPhysics(),
//                   controller:
//                       controller.scrollController,
//                   itemCount:
//                       controller.jobs.length +
//                       (controller.isLoadingMore.value
//                           ? 1
//                           : 0),
//                   itemBuilder: (context, index) {
//                     if (index ==
//                         controller.jobs.length) {
//                       return const Padding(
//                         padding:
//                             EdgeInsets.all(16),
//                         child: Center(
//                           child:
//                               CircularProgressIndicator(),
//                         ),
//                       );
//                     }

//                     final job =
//                         controller.jobs[index];

//                     return Card(
//                       margin:
//                           const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       child: ListTile(
//                         onTap: () {
//                           Get.toNamed(
//                             AppRoutes.jobDetails,
//                             arguments: job,
//                           );
//                         },
//                         leading: CircleAvatar(
//                           backgroundImage:
//                               job.employerLogo
//                                       .isNotEmpty
//                                   ? NetworkImage(
//                                       job.employerLogo,
//                                     )
//                                   : null,
//                           child: job.employerLogo
//                                   .isEmpty
//                               ? const Icon(
//                                   Icons.business,
//                                 )
//                               : null,
//                         ),
//                         title: Text(
//                           job.jobTitle,
//                         ),
//                         // subtitle: Text(
//                         //   job.employerName,
//                         // ),
//                         trailing: Text(
//                           job.jobLocation,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }


//===================================================== Version 2 ==================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/core/widgets/job_card_skeleton.dart';
import 'package:job_finder_app/core/widgets/skeleton_loading.dart';
import 'package:job_finder_app/modules/search/controller/search_job_controller.dart';

class SearchView extends GetView<SearchJobController> {
  const SearchView({super.key});

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
    final inputBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    const secondaryColor = Color(0xFF36BFFA);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Search Jobs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: inputBg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark 
                        ? Colors.black.withOpacity(0.2) 
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.onSearchChanged,
                onSubmitted: (_) {
                  controller.searchJobs();
                },
                style: TextStyle(color: textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search jobs...',
                  hintStyle: TextStyle(color: textSecondary),
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  suffixIcon: IconButton(
                    onPressed: controller.searchJobs,
                    icon: Icon(Icons.send, color: primaryColor),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Results',
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(height: 12),
        

          Expanded(
            child: Obx(
              () {
                
                if (controller.isLoading.value) {
                  return SkeletonLoading(
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (_,__){
                        return const JobCardSkeleton();
                      },
                    ),
                  );
                }

                if(controller.currentQuery.isEmpty){
                  return _buildSearchHistory();
                }

                if (controller.jobs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: textSecondary.withOpacity(0.4),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No jobs found',
                          style: TextStyle(
                            fontSize: 18,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: primaryColor,
                  onRefresh: controller.refreshJobs,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller.scrollController,
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: controller.jobs.length + (controller.isLoadingMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.jobs.length) {
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: CircularProgressIndicator(color: secondaryColor),
                          ),
                        );
                      }

                      final job = controller.jobs[index];

                      return Card(
                        color: cardColor,
                        elevation: 2,
                        shadowColor: primaryColor.withOpacity(0.12),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
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
                                  radius: 28,
                                  backgroundColor: primaryColor.withOpacity(0.1),
                                  backgroundImage: job.employerLogo.isNotEmpty
                                      ? NetworkImage(job.employerLogo)
                                      : null,
                                  child: job.employerLogo.isEmpty
                                      ? Icon(Icons.business, color: primaryColor)
                                      : null,
                                ),

                                const SizedBox(width: 14),

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

                                      const SizedBox(height: 10),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: secondaryColor,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              job.jobLocation.isEmpty ? 'Remote' : job.jobLocation,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: textSecondary),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),

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

                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: textSecondary.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

Widget _buildSearchHistory() {
  return Obx(
    () => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
         
          if (controller.searchHistory.isNotEmpty)
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                TextButton(
                  onPressed: controller.clearSearchHistory,
                  child: const Text('Clear All'),
                ),
              ],
            ),
          

            Wrap(
              spacing: 10,
              runSpacing: 5,
              children: controller.searchHistory.map((item) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.history,
                    ),

                    title: Text(item),

                    onTap: () {
                      controller.searchController.text =
                          item;

                      controller.searchJobs();
                    },

                    trailing: IconButton(
                      icon: const Icon(Icons.close),

                      onPressed: () {
                        controller.removeSearchHistory(
                          item,
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            )
          //  else 
          //   // Optional: small empty state, keeps layout consistent
          //   const Padding(
          //     padding: EdgeInsets.symmetric(vertical: 4),
          //     child: Text(
          //       'No recent searches',
          //       style: TextStyle(
          //         fontSize: 13,
          //         color: Colors.grey,
          //       ),
          //     ),
          //   ),
        ],
      ),
    ),
  );
}
}