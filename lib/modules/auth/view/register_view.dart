import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class RegisterView
    extends GetView<AuthController> {

  const RegisterView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller:
                  controller.nameController,
              decoration:
                  const InputDecoration(
                labelText: 'Name',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

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

            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          controller.register();
                        },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Register',
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}