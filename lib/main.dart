import 'package:contacts/core/app_routes.dart';
import 'package:contacts/core/app_strings.dart';
import 'package:contacts/pages/custom_widget/custom_widget_page.dart';
import 'package:contacts/pages/landing/landing_page.dart';
import 'package:contacts/pages/landing/landing_page_controller.dart';
import 'package:contacts/pages/login/login_page.dart';
import 'package:contacts/pages/login/login_page_controller.dart';
import 'package:contacts/services/api_service.dart';
import 'package:contacts/services/lang/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      onGenerateTitle: (BuildContext context) {
        return AppString.appName.tr;
      },
      debugShowCheckedModeBanner: false,
      defaultTransition: GetPlatform.isIOS ? Get.defaultTransition : Transition.cupertino,
      initialRoute: AppRoutes.login,
      initialBinding: BindingsBuilder(() {
        Get.put(ApiService());
      }),
      onInit: () {},
      getPages: [
        GetPage(
          name: AppRoutes.login,
          page: () => const LoginPage(),
          binding: BindingsBuilder(() {
            Get.put(LoginPageController());
          }),
        ),
        GetPage(
          name: AppRoutes.landing,
          page: () => const LandingPage(),
          binding: BindingsBuilder(() {
            Get.put(LandingPageController(
              apiService: Get.find(),
            ));
          }),
        ),
        GetPage(
          name: AppRoutes.customWidget,
          page: () => const CustomWidgetPage(),
          binding: BindingsBuilder(() {}),
        ),
      ],
    );
  }
}
