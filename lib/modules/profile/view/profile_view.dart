import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/modules/profile/controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    print(
  controller.authController.user.value?.avatar,
);

    return Scaffold(
      body: Obx(
        () {

          final user =
              controller
                  .authController
                  .user
                  .value;

          if (user == null) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),

              child: Column(
                children: [

                  const SizedBox(
                    height: 20,
                  ),
                  

                  GestureDetector(
                    onTap: controller
                        .authController
                        .uploadAvatar,

                    child: Obx(
                      () {

                        final user =
                            controller
                                .authController
                                .user
                                .value;

                        return CircleAvatar(
                          radius: 55,

                          backgroundImage:
                              user?.avatar.isNotEmpty == true
                                  ? NetworkImage(
                                     user!.avatar,
                                    )
                                  : null,

                          child:
                              user?.avatar.isEmpty ?? true
                                  ? const Icon(
                                      Icons.person,
                                      size: 55,
                                    )
                                  : null,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.person_outline,
                      ),
                      title: Text(
                        'edit_profile'.tr,
                      ),
                      trailing:
                          const Icon(
                        Icons
                            .arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () {
                        controller.openEditProfile();
                      },
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.lock_outline,
                      ),
                      title: Text(
                        'change_password'.tr,
                      ),
                      trailing:
                          const Icon(
                        Icons
                            .arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () {},
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text('logout'.tr),
                      onTap: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('logout'.tr),
                              content: Text('are_you_sure_you_want_to_logout?'.tr),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(), 
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.green,
                                  ),
                                  child: Text('cancel'.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    controller.logout(); 
                                  },

                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: Text('yes,logout'.tr),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),

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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}