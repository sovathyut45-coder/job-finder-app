import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
// ✅ CORRECT IMPORT for initializeDateFormatting (intl 0.20.x)
import 'package:intl/date_symbol_data_local.dart';
import 'package:job_finder_app/core/Theme/app_theme.dart';
import 'package:job_finder_app/core/routes/app_pages.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/initialBinding/initial_binding.dart';
import 'package:job_finder_app/translations/app_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // ✅ Correct call — no extra null argument
  await initializeDateFormatting('en_US');
  
  runApp(
    DevicePreview(
      enabled: false, //!kReleaseMode,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //useInheritedMediaQuery: true,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      translations: AppTranslation(),
      fallbackLocale: const Locale('en', 'US'),
      locale: Locale('en', 'US'),
      //builder: DevicePreview.appBuilder,
      getPages: AppPages.routes,
      initialRoute: AppRoutes.splash,
      initialBinding: InitialBinding(),
    );
    
  }
}
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:get_storage/get_storage.dart';
// // ✅ CORRECT IMPORT for initializeDateFormatting (intl 0.20.x)
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:job_finder_app/core/Theme/app_theme.dart';
// import 'package:job_finder_app/core/routes/app_pages.dart';
// import 'package:job_finder_app/core/routes/app_routes.dart';
// import 'package:job_finder_app/initialBinding/initial_binding.dart';
// import 'package:job_finder_app/translations/app_translation.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   // ✅ Correct call — no extra null argument
//   await initializeDateFormatting('en_US');
//   runApp(
//     DevicePreview(
//       enabled: false,
//       builder: (context) => const MainApp(),
//     ),
//   );
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: ThemeMode.system,
//       translations: AppTranslation(),
//       fallbackLocale: const Locale('en', 'US'),
//       locale: const Locale('en', 'US'),
//       getPages: AppPages.routes,
//       initialRoute: AppRoutes.splash,
//       initialBinding: InitialBinding(),
//     );
//   }
// }