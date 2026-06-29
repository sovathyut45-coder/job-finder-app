import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller:
                  controller.emailController,
              decoration:
                  const InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  controller.passwordController,
              obscureText: true,
              decoration:
                  const InputDecoration(
                labelText: 'Password',
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.login();
                },
                child: const Text(
                  'Login',
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Get.toNamed(
                  '/register',
                );
              },
              child: const Text(
                'Create Account',
              ),
            ),
          ],
        ),
      ),
    );
  }
}