import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/modules/job_detail/controller/job_detail_controller.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

class JobDetailView extends GetView<JobDetailController> {
  const JobDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final saveController = Get.find<SavedJobsController>();
    
    return Scaffold(
      appBar: AppBar(
        
        title: Obx(() {
          final job = controller.job.value;
          if (job == null) {
            return const Text('Job Detail');
          }

          final isSaved =
              saveController.isSaved(job.jobId);

          return Row(
            children: [
              Expanded(
                child: Text(
                  job.jobTitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  isSaved
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onPressed: () {
                  if (isSaved) {
                    saveController.removeJob(
                      job.jobId,
                    );
                  } else {
                    saveController.saveJob(
                      job,
                    );
                  }
                },
              ),
            ],
          );
        }),
      ),
        
      body: Obx(() {
        // Show loading indicator
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message
        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Error: ${controller.error.value}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }

        // Show message if no job data
        final jobData = controller.job.value;
        if (jobData == null) {
          return const Center(child: Text('No job details available'));
        }

        // Main content when data is ready
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                    child: Image.network(
                      jobData.employerLogo,
                      filterQuality: FilterQuality.high,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.business, size: 40),
                          
                    ),
                  ),
                )
              ),

              const SizedBox(height: 20),

              Text(
                jobData.jobTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              Text("Company: ${jobData.employerName}"),
              Text("Location: ${jobData.jobLocation}"),

              const SizedBox(height: 16),
              if (jobData.employmentType.isNotEmpty)
              Chip(

                label: Text(jobData.employmentType),
              ),

              const SizedBox(height: 16),
              
              const SizedBox(height: 4),
              if (jobData.minSalary > 0 || jobData.maxSalary > 0)
                Text(
                  'Salary: ${jobData.minSalary.toStringAsFixed(2)} - ${jobData.maxSalary.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 20),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Html(data: jobData.description),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.applyJob(
                      jobData.applyLink,
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text(
                    'Apply Now',
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      
    );
    
  }
}