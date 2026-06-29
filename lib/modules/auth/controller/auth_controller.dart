import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/data/model/user_model.dart';
import 'package:job_finder_app/modules/auth/repository/auth_repository.dart';

class AuthController extends GetxController {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final nameController =
      TextEditingController();

  RxBool isLoading = false.obs;
  final box = GetStorage();

  final AuthRepository repository;
  AuthController(this.repository);

  final authService =
    Get.find<AuthService>();

   Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();

    if (authService.isLoggedIn) {
      getProfile();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    try {
      isLoading.value = true;

      await repository.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.snackbar(
        'Success',
        'Register Success',
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final response =
          await repository.login(
        email: emailController.text.trim(),
        password:
            passwordController.text.trim(),
      );

      final token =
          response.data['token'];
      Get.find<AuthService>().saveToken(token);

      await getProfile();

      Get.offAllNamed(
        AppRoutes.dashboard,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> getProfile()async{
  //   try{
  //     isLoading.value = true;
  //     final response = await repository.profile(authService.token!);
  //     user.value = UserModel.fromJson(response.data['user']);
  //         print(
  //     user.value?.name,
  //   );
  //   }catch(e){
  //     Get.snackbar('Error', e.toString());
  //   }finally{
  //     isLoading.value = false;
  //   }
  // }

  Future<void> getProfile() async {
  try {
    final response =
        await repository.profile(
      authService.token!,
    );

    user.value = UserModel.fromJson(
      response.data['user'],
    );

  } catch (e) {
    print(
      'PROFILE ERROR: $e',
    );
  }
}
}