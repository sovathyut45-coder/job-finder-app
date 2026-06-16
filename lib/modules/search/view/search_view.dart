import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/search/controller/search_job_controller.dart';

class SearchView extends GetView<SearchJobController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Jobs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller.searchController,
              onChanged: controller.onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search jobs...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: controller.searchJobs,
                  icon: const Icon(Icons.send),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) {
                controller.searchJobs();
              },
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.jobs.isEmpty) {
                return const Center(
                  child: Text(
                    'No jobs found',
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refreshJobs,
                child: ListView.builder(
                  physics:
                      const AlwaysScrollableScrollPhysics(),
                  controller:
                      controller.scrollController,
                  itemCount:
                      controller.jobs.length +
                      (controller.isLoadingMore.value
                          ? 1
                          : 0),
                  itemBuilder: (context, index) {
                    if (index ==
                        controller.jobs.length) {
                      return const Padding(
                        padding:
                            EdgeInsets.all(16),
                        child: Center(
                          child:
                              CircularProgressIndicator(),
                        ),
                      );
                    }

                    final job =
                        controller.jobs[index];

                    return Card(
                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.jobDetails,
                            arguments: job,
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              job.employerLogo
                                      .isNotEmpty
                                  ? NetworkImage(
                                      job.employerLogo,
                                    )
                                  : null,
                          child: job.employerLogo
                                  .isEmpty
                              ? const Icon(
                                  Icons.business,
                                )
                              : null,
                        ),
                        title: Text(
                          job.jobTitle,
                        ),
                        // subtitle: Text(
                        //   job.employerName,
                        // ),
                        trailing: Text(
                          job.jobLocation,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}