import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

class SavedJobsView
    extends GetView<
        SavedJobsController> {

  const SavedJobsView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Obx(
        () {
          if (controller
              .savedJobs
              .isEmpty) {
            return const Center(
              child: Text(
                'No Saved Jobs',
              ),
            );
          }

          return ListView.builder(
            itemCount: controller
                .savedJobs.length,
            itemBuilder:
                (context, index) {
              final job = controller
                  .savedJobs[index];

              return ListTile(
                title: Text(
                  job.jobTitle,
                ),
                subtitle: Text(
                  job.employerName,
                ),
                trailing:
                    IconButton(
                  onPressed: () {
                    controller
                        .removeJob(
                      job.jobId,
                    );
                  },
                  icon:
                      const Icon(
                    Icons.delete,
                  ),
                ),
              );
            },
          );
        },
    );
  }
}