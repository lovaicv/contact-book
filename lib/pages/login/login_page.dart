import 'dart:ui';

import 'package:contacts/core/app_colors.dart';
import 'package:contacts/core/app_images.dart';
import 'package:contacts/core/app_routes.dart';
import 'package:contacts/core/app_strings.dart';
import 'package:contacts/pages/login/login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade200,
                Colors.blue.shade100,
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          //     border: Border.all(color: Colors.white, width: 2)
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 56),
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)), border: Border.all(color: Colors.white, width: 2)),
                      child: Image.asset(AppImage.flutter),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppString.loginTitle.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppString.loginMessage.tr,
                    )),
                const SizedBox(height: 20),
                Container(
                    color: Colors.white,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: AppString.username.tr,
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: Obx(() => TextField(
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: controller.isShowPassword.value,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 16),
                          hintText: AppString.password.tr,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showPassword();
                            },
                            icon: Icon(controller.isShowPassword.value ? MaterialCommunityIcons.eye_off : MaterialCommunityIcons.eye),
                          ),
                        ),
                      )),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppString.forgotPassword.tr,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.blue74D6FB,
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.landing);
                      },
                      child: Text(AppString.login.tr)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
