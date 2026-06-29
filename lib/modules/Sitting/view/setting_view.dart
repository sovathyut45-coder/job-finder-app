import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';
import 'package:job_finder_app/modules/Sitting/controller/setting_controller.dart';
import 'package:job_finder_app/translations/language/controller/language_controller.dart';

class SettingView extends GetView<SettingController>{
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    final languageController =
    Get.find<LanguageController>();
    return Scaffold(
      appBar: AppBar(
        title:  Text('settings'.tr),
      ),
      body: Obx(
        (){
          return ListView(
            children: [
              SwitchListTile(
                title: Text(theme.isDark.value ? 'dark_mode'.tr: 'light_mode'.tr),
                value: theme.isDark.value,
                onChanged: (value) => theme.toggleTheme(),
              ),

              Obx(
                () => ListTile(
                  leading: const Icon(
                    Icons.language,
                  ),
                  title: Text(
                    'language'.tr,
                  ),
                  subtitle: Text(
                    languageController
                                .languageCode
                                .value ==
                            'en'
                        ? 'english'.tr
                        : 'khmer'.tr,
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        padding:
                            const EdgeInsets.all(
                          20,
                        ),
                        decoration: BoxDecoration(
                          color: theme.isDark.value ? const Color(0xFF1E293B) : Colors.white,
                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text(
                                'english'.tr,
                              ),
                              onTap: () {
                                languageController
                                    .changeLanguage(
                                  'en',
                                );

                                Get.back();
                              },
                            ),

                            ListTile(

                              title: Text(
                                'khmer'.tr,
                              ),
                              onTap: () {
                                languageController
                                    .changeLanguage(
                                  'km',
                                );

                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              ListTile(
                leading: const Icon(
                  Icons.history,
                ),
                title:  Text(
                  'clear_search_history'.tr,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  controller.showClearDialog(
                    title: 'clear_search_history'.tr,
                    onConfirm: () {
                      controller.clearSearchHistory();
                    },
                  );
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.delete,
                ),
                title:  Text(
                  'clear_saved_jobs'.tr,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  controller.showClearDialog(
                    title: 'clear_saved_jobs'.tr,
                    onConfirm: () {
                      controller.clearSavedJobs();
                    },
                  );
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.delete,
                ),
                title:  Text(
                  'clear_recent_jobs'.tr,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  controller.showClearDialog(
                    title: 'clear_recent_jobs'.tr,
                    onConfirm: () {
                      controller.clearRecentJobs();
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                ),
                title:  Text(
                  'about_app'.tr,
                ),
                subtitle:  Text(
                  'job_finder_app'.tr,
                ),
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context!)
                            .cardColor,
                        borderRadius:
                            const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child:  Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'job_finder'.tr,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'built_with_flutter_getx'.tr,
                          ),
                        ],
                      ),
                    ),
                    isScrollControlled: true,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("contact_us".tr),
                onTap: (){},
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text("logout".tr),
                onTap: (){},
              ),
            ],
          );
        }
      ),
      
    );
  }
}