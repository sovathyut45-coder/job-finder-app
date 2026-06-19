import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/core/Theme/theme_controller.dart';

class SettingView extends GetView<ThemeController>{
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Obx(
        (){
          return ListView(
            children: [
              SwitchListTile(
                title: Text(controller.isDark.value ? 'Dark Mode' : 'Light Mode'),
                value: controller.isDark.value,
                onChanged: (value) => controller.toggleTheme(),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text("About App"),
                onTap: (){},
              ),

              ListTile(
                leading: Icon(Icons.info),
                title: Text("Version 1.0"),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Contact Us"),
                onTap: (){},
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: (){},
              ),
            ],
          );
        }
      ),
      
    );
  }
}