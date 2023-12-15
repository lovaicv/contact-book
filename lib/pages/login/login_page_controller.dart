import 'package:get/get.dart';

class LoginPageController extends GetxController {
  RxBool isShowPassword = true.obs;

  showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}
