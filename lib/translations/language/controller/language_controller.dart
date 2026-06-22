import 'dart:ui';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final box = GetStorage();

  RxString languageCode = 'en'.obs;

  @override
  void onInit() {
    super.onInit();

    languageCode.value =
        box.read('language') ?? 'en';

    changeLanguage(
      languageCode.value,
      save: false,
    );
  }

  void changeLanguage(
    String code, {
    bool save = true,
  }) {
    languageCode.value = code;

    if (save) {
      box.write('language', code);
    }

    Get.updateLocale(
      code == 'km'
          ? const Locale('km', 'KH')
          : const Locale('en', 'US'),
    );
  }
}