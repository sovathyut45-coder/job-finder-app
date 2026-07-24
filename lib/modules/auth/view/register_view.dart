// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/auth_controller.dart';

// class RegisterView
//     extends GetView<AuthController> {

//   const RegisterView({
//     super.key,
//   });

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Register',
//         ),
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.all(16),
//         child: Column(
//           children: [

//             TextField(
//               controller:
//                   controller.nameController,
//               decoration:
//                   const InputDecoration(
//                 labelText: 'Name',
//               ),
//             ),

//             const SizedBox(
//               height: 16,
//             ),

//             TextField(
//               controller:
//                   controller.emailController,
//               decoration:
//                   const InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),

//             const SizedBox(
//               height: 16,
//             ),

//             TextField(
//               controller:
//                   controller.passwordController,
//               obscureText: true,
//               decoration:
//                   const InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),

//             const SizedBox(
//               height: 24,
//             ),

//             Obx(
//               () => SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.isLoading.value
//                       ? null
//                       : () {
//                           controller.register();
//                         },
//                   child: controller.isLoading.value
//                       ? const CircularProgressIndicator()
//                       : const Text(
//                           'Register',
//                         ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class RegisterView extends GetView<AuthController>{
  const RegisterView({super.key});
  

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction, // auto show error when you valid ដោយមិនចាំបាច់ចុច Button
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo1.png',
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Create your account and start", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 8),
                  Text("finding your dream job"),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      if(value.length > 20) {
                        return 'Name must be less than 20 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if(!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password...',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if(value.length < 8) {
                        return 'password_must_be_at_least_8_characters'.tr;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),

                  SizedBox(height: 8),

                  TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password...',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'confirm_password_required'.tr;
                      }
                      if(value != controller.passwordController.text) {
                        return 'passwords_do_not_match'.tr;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                        
                  SizedBox(height: 16),
                  Obx(
                    () => SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  controller.register();
                                }
                              },
                        child: controller.isLoading.value
                            ? const SizedBox(
                                      width:22,
                                      height:22,
                                      child:CircularProgressIndicator(
                                        strokeWidth:2,
                                        color: Colors.white,
                                      ),
                                    )
                            : const Text(
                                'Create Account',style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(
                                '/login',
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
      )
    );
  }
}