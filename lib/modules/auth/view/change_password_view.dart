import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class ChangePasswordView extends GetView<AuthController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textSecondary =
        theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: Text('change_password'.tr),
        centerTitle: true,
      ),
      body: PopScope(
        onPopInvokedWithResult: (didPop , result){
          if(didPop){
            controller.clearChangePasswordFields();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.changePasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        
                  const SizedBox(height: 20),
        
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 24),
        
                  Center(
                    child: Text(
                      'change_password'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 8),
        
                  Center(
                    child: Text(
                      'update_your_password_to_keep_your_account_secure'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: textSecondary,
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 32),
        
                  // Current Password
                  Obx(
                    () => TextFormField(
                      controller:
                          controller.currentPasswordController,
                      obscureText:
                          controller.isCurrentPasswordHidden.value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'current_password_required'.tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'current_password'.tr,
                        hintText: 'enter_current_password'.tr,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed:
                              controller.toggleCurrentPassword,
                          icon: Icon(
                            controller.isCurrentPasswordHidden.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 20),
        
                  // New Password
                  Obx(
                    () => TextFormField(
                      controller:
                          controller.newPasswordController,
                      obscureText:
                          controller.isNewPasswordHidden.value,
                      validator:(value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'new_password_required'.tr;
                        }
                        if(value.length < 8) {
                          return 'password_must_be_at_least_8_characters'.tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'new_password'.tr,
                        hintText: 'enter_new_password'.tr,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed:
                              controller.toggleNewPassword,
                          icon: Icon(
                            controller.isNewPasswordHidden.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 20),
        
                  // Confirm Password
                  Obx(
                    () => TextFormField(
                      controller:
                          controller.confirmPasswordController,
                      obscureText:
                          controller.isConfirmPasswordHidden.value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                            return 'confirm_password_required'.tr;
                          }
        
                          if (value != controller.newPasswordController.text) {
                            return 'passwords_do_not_match'.tr;
                          }
        
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'confirm_new_password'.tr,
                        hintText: 'confirm_new_password'.tr,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed:
                              controller.toggleConfirmPassword,
                          icon: Icon(
                            controller.isConfirmPasswordHidden.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 32),
        
                  // Submit Button
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                              if(controller.changePasswordFormKey.currentState!.validate()) {
        
                                controller.changePassword();
                            }
                            },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'change_password'.tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}