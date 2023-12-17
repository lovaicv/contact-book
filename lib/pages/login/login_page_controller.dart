import 'package:contacts/core/app_routes.dart';
import 'package:contacts/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isShowPassword = true.obs;
  RxBool isUserNameError = false.obs;
  RxBool isPasswordError = false.obs;

  showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  login() {
    if (usernameController.text.isNullOrEmpty) isUserNameError.value = true;
    if (passwordController.text.isNullOrEmpty) isPasswordError.value = true;
    if (!isUserNameError.value && !isPasswordError.value) Get.offAndToNamed(AppRoutes.landing);
  }

  removeError(RxBool isError) {
    isError.value = false;
  }
}
