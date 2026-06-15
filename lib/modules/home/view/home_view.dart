import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: controller.refreshJobs,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Find Your Dream Job',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Discover opportunities that match your skills',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.search,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Text('Search jobs...'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Popular Positions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  controller.positions.map(
                (position) {
                  return ActionChip(
                    label: Text(position),
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.search,
                        arguments: position,
                      );
                    },
                  );
                },
              ).toList(),
            ),

            const SizedBox(height: 24),

            const Text(
              'Popular Jobs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (controller.isLoading.value)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child:
                      CircularProgressIndicator(),
                ),
              )
            else if (controller.jobs.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'No jobs found',
                  ),
                ),
              )
            else
              ...controller.jobs.map(
                (job) {
                  return Card(
                    margin:
                        const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.jobDetails,
                          arguments: job.jobId,
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
                      subtitle: Text(
                        job.employerName,
                      ),
                      trailing: Text(
                        job.jobCity,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}