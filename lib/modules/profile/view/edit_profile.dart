import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class EditProfileView extends GetView<AuthController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('edit_profile'.tr),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [

                /// Avatar
                GestureDetector(
                  onTap: controller.uploadAvatar,
                  child: Obx(() {
                    final user = controller.user.value;

                    return CircleAvatar(
                      radius: 55,
                      backgroundImage:
                          user?.avatar.isNotEmpty == true
                              ? NetworkImage(user!.avatar)
                              : null,
                      child: user?.avatar.isEmpty ?? true
                          ? const Icon(
                              Icons.person,
                              size: 55,
                            )
                          : null,
                    );
                  }),
                ),

                const SizedBox(height: 30),

                /// Name
                TextFormField(
                  controller: controller.editNameController,
                  decoration: InputDecoration(
                    labelText: 'name'.tr,
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// Email
                TextFormField(
                  controller: controller.editEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'email'.tr,
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                /// Update Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: controller.isUpdating.value
                          ? null
                          : () {
                              if (formKey.currentState!
                                  .validate()) {
                                controller.updateProfile();
                              }
                            },
                      child: controller.isUpdating.value
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'update'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
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
    );
  }
}