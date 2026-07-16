import 'package:get/get.dart';
import 'package:job_finder_app/data/datasource/job_datasource.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/search/controller/search_job_controller.dart';


class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobDatasource>(
      () => JobDatasource(),
    );

    Get.lazyPut<JobRepository>(
      () => JobRepository(
        Get.find<JobDatasource>(),
      ),
    );

    Get.lazyPut<SearchJobController>(
      () => SearchJobController(
        Get.find<JobRepository>(),
      ),
    );
  }
}