import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/core/Service/auth_service.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/data/model/user_model.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/auth/repository/auth_repository.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';

class AuthController extends GetxController {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();
  final confirmPasswordController =
      TextEditingController();
  final currentPasswordController = TextEditingController();

  final nameController =
      TextEditingController();

  RxBool isLoading = false.obs;
  final box = GetStorage();

  final AuthRepository repository;
  AuthController(this.repository);

  final authService =
    Get.find<AuthService>();

  Rxn<UserModel> user = Rxn<UserModel>();

  final editNameController = TextEditingController();

  final editEmailController = TextEditingController();

  final isUpdating = false.obs;

  final ImagePicker picker = ImagePicker();

  final isUploading = false.obs;

  final forgotPasswordFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();

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

    editNameController.dispose();
    editEmailController.dispose();
    confirmPasswordController.dispose();
    currentPasswordController.dispose();

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

      // await getProfile();

      // if (Get.isRegistered<SavedJobsController>()) {
      //   await Get.find<SavedJobsController>().getSavedJobs();
      // }

      // if (Get.isRegistered<AppliedJobsController>()) {
      //   await Get.find<AppliedJobsController>().getAppliedJob();
      // }

      // option 2
      // load Qickly data after login
      await Future.wait([
        getProfile(),

        if (Get.isRegistered<SavedJobsController>())
          Get.find<SavedJobsController>().getSavedJobs(),

        if (Get.isRegistered<AppliedJobsController>())
          Get.find<AppliedJobsController>().getAppliedJob(),
      ]);


      Get.offAllNamed(
        AppRoutes.dashboard,
      );

    } on DioException catch (e) {
  print(e.response?.data);

  Get.snackbar(
    'Login Failed',
    e.response?.data['message'] ?? 'Unknown error',
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
  );
} finally {
      isLoading.value = false;
    }
  }


  Future<void> logout() async {
    try {
      isLoading.value = true;

      await repository.logout(
        authService.token!,
      );

      authService.clearToken();

      user.value = null;

      emailController.clear();
      passwordController.clear();
      nameController.clear();

      editNameController.clear();
      editEmailController.clear();

      Get.offAllNamed(
        AppRoutes.login,
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

  Future<void> getProfile() async {
    try {
      final response =
          await repository.profile(
        authService.token!,
      );

      user.value = UserModel.fromJson(
        response.data['user'],
      );
      //print(response.data);

    } catch (e) {
      print(
        'PROFILE ERROR: $e',
      );
    }
  }

  Future<void> updateProfile() async {
    try {

      isUpdating.value = true;

      final response =
          await repository.updateProfile(
        token: authService.token!,
        name:
            editNameController.text.trim(),
        email:
            editEmailController.text.trim(),
      );

      user.value =
          UserModel.fromJson(
        response.data['user'],
      );

      Get.back();

      Get.snackbar(
        'Success',
        'Profile Updated',
      );

    } catch (e) {

      Get.snackbar(
        'Error',
        e.toString(),
      );

    } finally {

      isUpdating.value = false;
    }
  }

  // Future<void> uploadAvatar() async {

  //   try {

  //     final file =
  //         await picker.pickImage(
  //       source: ImageSource.gallery,
  //     );

  //     if (file == null) return;

  //     isUploading.value = true;

  //     await repository.uploadAvatar(
  //       token: authService.token!,
  //       imagePath: file.path,
  //     );

  //     await getProfile();

  //   } catch (e) {

  //     Get.snackbar(
  //       'Error',
  //       e.toString(),
  //     );

  //   } finally {

  //     isUploading.value = false;
  //   }
  // }

  Future<void> uploadAvatar() async {

    try {

      final XFile? file =
          await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (file == null) return;

      isUploading.value = true;

      await repository.uploadAvatar(
        token: authService.token!,
        file: file,
      );

      await getProfile();

      Get.snackbar(
        'Success',
        'Avatar Updated',
      );

    } catch (e) {

      Get.snackbar(
        'Error',
        e.toString(),
      );

    } finally {

      isUploading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    try {
      isLoading.value = true;

      await repository.forgotPassword(
        {
          'email': emailController.text.trim(),
        }
      );
      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
      );
      emailController.clear();
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

  Future<void> changePassword() async {
    try {
      isLoading.value = true;
      await repository.changePassword(
        token: authService.token!,
        data: {
          'current_password' : currentPasswordController.text.trim(),
          'password': passwordController.text.trim(),
          'password_confirmation': confirmPasswordController.text.trim(),
        },
      );
      Get.snackbar(
        'Success',
        'Password changed successfully',
      );

      authService.clearToken();
      currentPasswordController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      Get.offAllNamed(
        AppRoutes.login,
      );
        
    }catch(e){
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
    finally{
      isLoading.value = false;
    }
  }
}