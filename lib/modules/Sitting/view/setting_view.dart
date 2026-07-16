// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:job_finder_app/core/Theme/theme_controller.dart';
// import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
// import 'package:job_finder_app/modules/Sitting/controller/setting_controller.dart';
// import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';
// import 'package:job_finder_app/translations/language/controller/language_controller.dart';

// class SettingView extends GetView<SettingController>{
//   const SettingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Get.find<ThemeController>();
//     final languageController = Get.find<LanguageController>();
//     final savecontroller = Get.find<SavedJobsController>();
//     final appliedcontroller = Get.find<AppliedJobsController>();
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text('settings'.tr),
//       ),
//       body: Obx(
//         (){
//           return ListView(
//             children: [
//               SwitchListTile(
//                 title: Text(theme.isDark.value ? 'dark_mode'.tr: 'light_mode'.tr),
//                 value: theme.isDark.value,
//                 onChanged: (value) => theme.toggleTheme(),
//               ),

//               Obx(
//                 () => ListTile(
//                   leading: const Icon(
//                     Icons.language,
//                   ),
//                   title: Text(
//                     'language'.tr,
//                   ),
//                   subtitle: Text(
//                     languageController
//                                 .languageCode
//                                 .value ==
//                             'en'
//                         ? 'english'.tr
//                         : 'khmer'.tr,
//                   ),
//                   onTap: () {
//                     Get.bottomSheet(
//                       Container(
//                         padding:
//                             const EdgeInsets.all(
//                           20,
//                         ),
//                         decoration: BoxDecoration(
//                           color: theme.isDark.value ? const Color(0xFF1E293B) : Colors.white,
//                           borderRadius:
//                               BorderRadius.circular(
//                             20,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisSize:
//                               MainAxisSize.min,
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 'english'.tr,
//                               ),
//                               onTap: () {
//                                 languageController
//                                     .changeLanguage(
//                                   'en',
//                                 );

//                                 Get.back();
//                               },
//                             ),

//                             ListTile(

//                               title: Text(
//                                 'khmer'.tr,
//                               ),
//                               onTap: () {
//                                 languageController
//                                     .changeLanguage(
//                                   'km',
//                                 );

//                                 Get.back();
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               ListTile(
//                 leading: const Icon(
//                   Icons.history,
//                 ),
//                 title:  Text(
//                   'clear_search_history'.tr,
//                 ),
//                 trailing: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                 ),
//                 onTap: () {
//                   controller.showClearDialog(
//                     title: 'clear_search_history'.tr,
//                     onConfirm: () {
//                       controller.clearSearchHistory();
//                     },
//                   );
//                 },
//               ),

//               ListTile(
//                 leading: const Icon(
//                   Icons.delete,
//                 ),
//                 title:  Text(
//                   'clear_applied_jobs'.tr,
//                 ),
//                 trailing: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                 ),
//                 onTap: () {
//                   controller.showClearDialog(
//                     title: 'clear_applied_jobs'.tr,
//                     onConfirm: () {
//                       appliedcontroller.clearAppliedJob();
//                     },
//                   );
//                 },
//               ),

//               ListTile(
//                 leading: const Icon(
//                   Icons.delete,
//                 ),
//                 title:  Text(
//                   'clear_saved_jobs'.tr,
//                 ),
//                 trailing: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                 ),
//                 onTap: () {
//                   controller.showClearDialog(
//                     title: 'clear_saved_jobs'.tr,
//                     onConfirm: () {
//                       savecontroller.clearSavedJobs();
                      
//                     },
//                   );
//                 },
//               ),

//               ListTile(
//                 leading: const Icon(
//                   Icons.delete,
//                 ),
//                 title:  Text(
//                   'clear_recent_jobs'.tr,
//                 ),
//                 trailing: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                 ),
//                 onTap: () {
//                   controller.showClearDialog(
//                     title: 'clear_recent_jobs'.tr,
//                     onConfirm: () {
//                       controller.clearRecentJobs();
//                     },
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.info_outline,
//                 ),
//                 title:  Text(
//                   'about_app'.tr,
//                 ),
//                 subtitle:  Text(
//                   'job_finder_app'.tr,
//                 ),
//                 onTap: () {
//                   Get.bottomSheet(
//                     Container(
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Theme.of(Get.context!)
//                             .cardColor,
//                         borderRadius:
//                             const BorderRadius.vertical(
//                           top: Radius.circular(24),
//                         ),
//                       ),
//                       child:  Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'job_finder'.tr,
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             'built_with_flutter_getx'.tr,
//                           ),
//                         ],
//                       ),
//                     ),
//                     isScrollControlled: true,
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.email),
//                 title: Text("contact_us".tr),
//                 onTap: (){},
//               ),

//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: Text("logout".tr),
//                 onTap: (){},
//               ),
//             ],
//           );
//         }
//       ),
      
//     );
//   }
// }

// ----------------------------------- Version 2 -----------------------------------

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/modules/ApplyJob/controller/applied_jobs_controller.dart';
import 'package:job_finder_app/modules/Sitting/controller/setting_controller.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';
import 'package:job_finder_app/modules/save_job/controller/saved_jobs_controller.dart';
import 'package:job_finder_app/translations/language/controller/language_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    final auth = Get.find<AuthController>();
    final languageController = Get.find<LanguageController>();
    final savecontroller = Get.find<SavedJobsController>();
    final appliedcontroller = Get.find<AppliedJobsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            // -------------------- Theme Section --------------------
            _buildSectionTitle('appearance'.tr),
            Card(
              elevation: 1,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: Text(
                  theme.isDark.value ? 'dark_mode'.tr : 'light_mode'.tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                secondary: Icon(
                  theme.isDark.value ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                value: theme.isDark.value,
                activeThumbColor: Theme.of(context).colorScheme.primary,
                onChanged: (_) => theme.toggleTheme(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // -------------------- Language Section --------------------
            _buildSectionTitle('preferences'.tr),
            Obx(
              () => Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'language'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    languageController.languageCode.value == 'en'
                        ? 'english'.tr
                        : 'khmer'.tr,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.isDark.value
                              ? const Color(0xFF1E293B)
                              : Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'select_language'.tr,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                              leading: const Icon(Icons.check_circle_outline),
                              title: Text('english'.tr),
                              onTap: () {
                                languageController.changeLanguage('en');
                                Get.back();
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.check_circle_outline),
                              title: Text('khmer'.tr),
                              onTap: () {
                                languageController.changeLanguage('km');
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // -------------------- Clear Data Section --------------------
            _buildSectionTitle('data_management'.tr),
            Card(
              elevation: 1,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    context: context,
                    icon: Icons.history,
                    title: 'clear_search_history'.tr,
                    onTap: () => controller.showClearDialog(
                      title: 'clear_search_history'.tr,
                      onConfirm: () => controller.clearSearchHistory(),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(
                    context: context,
                    icon: Icons.work_history,
                    title: 'clear_applied_jobs'.tr,
                    onTap: () => controller.showClearDialog(
                      title: 'clear_applied_jobs'.tr,
                      onConfirm: () => appliedcontroller.clearAppliedJob(),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(
                    context: context,
                    icon: Icons.bookmark_remove,
                    title: 'clear_saved_jobs'.tr,
                    onTap: () => controller.showClearDialog(
                      title: 'clear_saved_jobs'.tr,
                      onConfirm: () => savecontroller.clearSavedJobs(),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(
                    context: context,
                    icon: Icons.access_time,
                    title: 'clear_recent_jobs'.tr,
                    onTap: () => controller.showClearDialog(
                      title: 'clear_recent_jobs'.tr,
                      onConfirm: () => controller.clearRecentJobs(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // -------------------- App Info & Actions --------------------
            _buildSectionTitle('about'.tr),
            Card(
              elevation: 1,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    context: context,
                    icon: Icons.info_outline,
                    title: 'about_app'.tr,
                    subtitle: 'job_finder_app'.tr,
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Theme.of(Get.context!).cardColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'job_finder'.tr,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'built_with_flutter_getx'.tr,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => Get.back(),
                                child: Text('ok'.tr),
                              ),
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(
                    context: context,
                    icon: Icons.email_outlined,
                    title: 'contact_us'.tr,
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildSettingTile(
                    context: context,
                    icon: Icons.logout,
                    title: 'logout'.tr,
                    iconColor: Colors.redAccent,
                    textColor: Colors.redAccent,
                    onTap: () {
                      auth.logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Get.theme.colorScheme.primary.withValues(alpha: 0.8),
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  // Helper: Reusable ListTile
  Widget _buildSettingTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Get.theme.colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: textColor,
            ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: onTap,
    );
  }
}