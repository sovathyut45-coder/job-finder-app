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

      Get.offAllNamed(
        AppRoutes.login,
      );
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      nameController.clear();
    } on DioException catch (e) {

      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'Register Failed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  e.response?.data['message'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.red,
                      elevation: 0,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Get.offAllNamed(
                      AppRoutes.register,
                    ),
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ),
        )
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

      emailController.clear();
      passwordController.clear();

    } on DioException catch (e) {
        Get.dialog(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Login Failed',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    e.response?.data['message'] ?? 'Invalid credentials',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Get.offAndToNamed(
                        AppRoutes.login,
                      ),
                      child: const Text('OK'),
                    ),
                  ),
                ],
              ),
            ),
          ),
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