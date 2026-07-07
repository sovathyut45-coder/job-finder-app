import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:job_finder_app/modules/auth/controller/auth_controller.dart';

class EditProfileView
    extends GetView<AuthController> {

  const EditProfileView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          'edit_profile'.tr,
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller:
                  controller
                      .editNameController,
              decoration:
                  InputDecoration(
                labelText: 'name'.tr,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
                  controller
                      .editEmailController,
              decoration:
                  InputDecoration(
                labelText: 'email'.tr,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Obx(
              () => ElevatedButton(

                onPressed:
                    controller.isUpdating.value
                        ? null
                        : controller
                            .updateProfile,

                child:
                    controller
                            .isUpdating
                            .value
                        ? const CircularProgressIndicator()
                        : Text(
                            'update'.tr,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}