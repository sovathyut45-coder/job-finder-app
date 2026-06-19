import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {

  final box = GetStorage();

  final isDark = false.obs;

  @override
  void onInit() {
    super.onInit();

    isDark.value =
        box.read('isDark') ?? false;

    Get.changeThemeMode(
      isDark.value
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  void toggleTheme() {

    isDark.toggle();

    box.write(
      'isDark',
      isDark.value,
    );

    Get.changeThemeMode(
      isDark.value
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}