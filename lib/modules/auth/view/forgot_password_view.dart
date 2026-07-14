import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/routes/app_routes.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class ForgotpasswordView extends GetView<AuthController>{
  const ForgotpasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Forgot Password", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(height: 60,),
                Text("Please enter your email address to receive a link to reset your password",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: 20,),
                Form(
                  key: controller.forgotPasswordFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if(!GetUtils.isEmail(value)){
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Obx(
                  ()=>SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                            if (controller.forgotPasswordFormKey.currentState!.validate()) {
                              controller.forgotPassword();
                            }
                          },
                      child: controller.isLoading.value
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                              'Send Reset Link',
                            ),
                    ),
                  ),
                ),
                SizedBox(height:10,),
                RichText(
                  text: TextSpan(
                    text: 'Back to ',
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAllNamed(
                              AppRoutes.login
                            );
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}