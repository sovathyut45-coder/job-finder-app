import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/modules/splash/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
     //print('SplashView Build');
    print(controller);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo1.png',
              width: 120,
            ),

            const SizedBox(height: 20),

             Text(
              'job_finder'.tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}