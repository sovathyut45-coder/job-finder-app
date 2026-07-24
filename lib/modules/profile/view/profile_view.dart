import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/profile/controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final user = controller.authController.user.value;

        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              Stack(
                children: [

                  GestureDetector(
                    onTap: controller.authController.uploadAvatar,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: user.avatar.isNotEmpty
                          ? NetworkImage(user.avatar)
                          : null,
                      child: user.avatar.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 60,
                            )
                          : null,
                    ),
                  ),

                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                user.email,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: Text('edit_profile'.tr),
                      trailing: const Icon(Icons.arrow_forward_ios,size:16),
                      onTap: controller.openEditProfile,
                    ),

                    const Divider(height: 1),

                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: Text('change_password'.tr),
                      trailing: const Icon(Icons.arrow_forward_ios,size:16),
                      onTap: () {
                        Get.toNamed(AppRoutes.changePassword);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('logout'.tr),
                        content: Text(
                          'are_you_sure_you_want_to_logout?'.tr,
                        ),
                        actions: [

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('cancel'.tr),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              controller.logout();
                            },
                            child: Text(
                              'yes,logout'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                      // GetX use

                      // Card(
                      //   child: ListTile(
                      //     leading: const Icon(
                      //       Icons.logout,
                      //     ),
                      //     title: const Text(
                      //       'Logout',
                      //     ),
                      //     onTap: () {
                      //       Get.defaultDialog(
                      //         title: 'Logout',
                      //         titleStyle: const TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.redAccent,
                      //         ),
                      //         middleText: 'Are you sure you want to log out?',
                      //         middleTextStyle: const TextStyle(fontSize: 16, color: Colors.black87),
                      //         backgroundColor: Colors.white, // ពណ៌ផ្ទៃខាងក្នុង
                      //         radius: 12, // មុំកែងមូល
                      //         barrierDismissible: false, // បិទមិនឱ្យចុចក្រៅដើម្បីបិទ
                      //         textConfirm: 'Yes, Logout',
                      //         confirmTextColor: Colors.white,
                      //         buttonColor: Colors.redAccent, // ពណ៌ផ្ទៃប៊ូតុង
                      //         textCancel: 'Cancel',
                      //         cancelTextColor: Colors.grey[700],
                      //         onConfirm: () {
                      //           Get.back();
                      //           controller.logout();
                      //         },
                      //         onCancel: () => Get.back(),
                      //       );
                            
                      //     },
                      //   ),
                      // ),
                  },
                  icon: const Icon(Icons.logout),
                  label: Text('logout'.tr),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}