import 'package:get/get.dart';
import 'package:job_finder_app/modules/auth/datasource/auth_datasource.dart';
import 'package:job_finder_app/modules/auth/repository/auth_repository.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AuthDatasource(),
      permanent: true,
    );

    Get.put(
      AuthRepository(
        Get.find<AuthDatasource>(),
      ),
      permanent: true,
    );

    Get.put(
      AuthController(
        Get.find<AuthRepository>(),
      ),
      permanent: true,
    );
  }
}