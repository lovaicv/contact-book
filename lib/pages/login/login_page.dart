import 'package:contacts/core/app_colors.dart';
import 'package:contacts/core/app_images.dart';
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
                Colors.blue.shade50,
                Colors.blue.shade100,
                Colors.blue.shade50,
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Container(
                        height: 220,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 56),
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
                  Material(
                    elevation: 1,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                    child: TextFormField(
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: AppString.username.tr,
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) return '';
                      //   return null;
                      // },
                      onChanged: (String string) {
                        controller.removeError(controller.isUserNameError);
                      },
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isUserNameError.value,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppString.usernameError.tr,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Material(
                    elevation: 1,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                    child: Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: controller.isShowPassword.value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 16),
                          hintText: AppString.password.tr,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showPassword();
                            },
                            icon: Icon(controller.isShowPassword.value ? MaterialCommunityIcons.eye_off : MaterialCommunityIcons.eye),
                          ),
                        ),
                        onChanged: (String string) {
                          controller.removeError(controller.isPasswordError);
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isPasswordError.value,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppString.passwordError.tr,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
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
                          controller.login();
                        },
                        child: Text(AppString.login.tr)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
