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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      onGenerateTitle: (BuildContext context) {
        return AppString.appName.tr;
      },
      debugShowCheckedModeBanner: false,
      defaultTransition: GetPlatform.isIOS ? Get.defaultTransition : Transition.cupertino,
      initialRoute: AppRoutes.login,
      initialBinding: BindingsBuilder(() {
        // Get.put(UserDb(hive: Hive));
        // Get.put(VideoDb(hive: Hive));
        // Get.put(BottomTabDb(hive: Hive));
        Get.put(ApiService());
        // Get.put(RemoteConfigService());
        // Get.put(ShareService());
        // Get.put(DarkModeService());
        // Get.put(NavigationService(apiService: Get.find()));
        // Get.put(DeepLinkService(apiService: Get.find()));
        // Get.put(LocalizationService());
        // Get.put(AuthenticationService(apiService: Get.find()));
        // Get.put(FirebaseNotificationService(), permanent: true);
        // Get.put(ConnectionController(), permanent: true);
        // Get.put(LocationController(), permanent: true);
        // Get.put(BottomBarController(connectionController: Get.find(), locationController: Get.find()), permanent: true);
      }),
      onInit: () {
        // showLog('app init here');
        // GetStorage().write(AppString.adPreviewCodeKey, '');
        // GetStorage().write(AppString.checkInitialLinkKey, true);
        // // bool? storageDarkMode = GetStorage().read(AppString.darkModeKey);
        // // if (storageDarkMode == null) {
        // //   bool isDarkMode = SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
        // //   Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
        // //   storageDarkMode = isDarkMode;
        // // } else {
        // //   Get.changeThemeMode(storageDarkMode ? ThemeMode.dark : ThemeMode.light);
        // // }
        // DarkModeService darkModeService = Get.find();
        // bool? isDarkMode = darkModeService.isDarkMode();
        // if (isDarkMode) {
        //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        // } else {
        //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        // }
      },
      getPages: [
        GetPage(
          name: AppRoutes.login,
          page: () => LoginPage(),
          binding: BindingsBuilder(() {
            Get.put(LoginPageController(
                // apiService: Get.find(),
                // bottomTabDb: Get.find(),
                // userDb: Get.find(),
                // videoDb: Get.find(),
                ));
          }),
        ),
        GetPage(
          name: AppRoutes.landing,
          page: () => LandingPage(),
          binding: BindingsBuilder(() {
            Get.put(LandingPageController(
              apiService: Get.find(),
              //     remoteConfigService: Get.find(),
              //     // localizationService: Get.find(),
              //     bottomTabDb: Get.find(),
            ));
            // Get.put(HomePageController(apiService: Get.find(), localizationService: Get.find(),));
            // Get.put(VideoPageController());
            // Get.put(PodcastPageController());
          }),
        ),
        GetPage(
          name: AppRoutes.customWidget,
          page: () => const CustomWidgetPage(),
          binding: BindingsBuilder(() {}),
        ),
        // GetPage(
        //   name: AppRoutes.webViewArticleNative,
        //   page: () => const WebViewArticleNativePage(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // GetPage(
        //   name: AppRoutes.videoList,
        //   page: () => const VideoListPage(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // GetPage(
        //   name: AppRoutes.podcastList,
        //   page: () => const PodcastListPage(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // GetPage(
        //   name: AppRoutes.pollList,
        //   page: () => const PollListPage(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // GetPage(
        //   name: AppRoutes.publisher,
        //   page: () => const PublisherPage(),
        //   binding: BindingsBuilder(() {
        //     // Get.put(PublisherPageController(
        //     //   apiService: Get.find(),
        //     //   localizationService: Get.find(),
        //     // ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.search,
        //   page: () => const SearchPage(),
        //   binding: BindingsBuilder(() {
        //     Get.put(SearchPageController(
        //       apiService: Get.find(),
        //       // localizationService: Get.find(),
        //     ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.highlight,
        //   page: () => const HighlightPage(),
        //   binding: BindingsBuilder(() {
        //     // Get.put(HighlightPageController(
        //     //   apiService: Get.find(),
        //     //   localizationService: Get.find(),
        //     // ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.hiddenPublisher,
        //   page: () => const HiddenPublisherPage(),
        //   binding: BindingsBuilder(() {
        //     // Get.put(HiddenPublisherPageController(
        //     //   apiService: Get.find(),
        //     //   // localizationService: Get.find(),
        //     // ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.following,
        //   page: () => const FollowingPage(),
        //   binding: BindingsBuilder(() {
        //     // Get.put(FollowingPageController(
        //     //   apiService: Get.find(),
        //     //   localizationService: Get.find(),
        //     // ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.history,
        //   page: () => const HistoryPage(),
        //   binding: BindingsBuilder(() {
        //     // Get.put(HistoryPageController(
        //     //   apiService: Get.find(),
        //     // localizationService: Get.find(),
        //     // ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.saved,
        //   page: () => const SavedPage(),
        //   binding: BindingsBuilder(() {
        //     // Get.put(SavedPageController(
        //     //   apiService: Get.find(),
        //     // localizationService: Get.find(),
        //     // ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.webView,
        //   page: () => const WebViewPage(),
        //   binding: BindingsBuilder(() {
        //     Get.put(WebViewPagerController(
        //       apiService: Get.find(),
        //       // localizationService: Get.find(),
        //     ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.temp,
        //   page: () => const TempPage(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // GetPage(
        //   name: AppRoutes.pushNotification,
        //   page: () => const PushNotificationPage(),
        //   binding: BindingsBuilder(() {
        //     // Get.put(PushNotificationPageController(
        //     //   apiService: Get.find(),
        //     //   userDb: UserDb(hive: Hive),
        //     //   // localizationService: Get.find(),
        //     // ));
        //   }),
        // ),
        // GetPage(
        //   name: AppRoutes.splashAd,
        //   page: () => const SplashAdPage(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // // GetPage(
        // //   name: AppRoutes.fullScreenVideo,
        // //   page: () => const FullScreenVideoWidget(),
        // //   binding: BindingsBuilder(() {}),
        // // ),
        // GetPage(
        //   name: AppRoutes.webViewArticleNativeImageViewer,
        //   page: () => const WebViewNativeImageViewer(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // GetPage(
        //   name: AppRoutes.contentNotFound,
        //   page: () => const ContentNotFound(),
        //   binding: BindingsBuilder(() {}),
        // ),
      ],
      // navigatorObservers: <NavigatorObserver>[observer],
      // routingCallback: (Routing? routing) {
      //   if (routing != null) {
      //     if (routing.current == AppRoutes.webViewArticleNative || routing.current == AppRoutes.webViewArticle) {
      //       GetStorage().write(AppString.userReadingArticleKey, true);
      //     }
      //     if (routing.current == AppRoutes.landing) {
      //       bool isUserReadingArticle = GetStorage().read(AppString.userReadingArticleKey) ?? false;
      //       int appOpenCount = GetStorage().read(AppString.appOpenCountKey) ?? 0;
      //       if (isUserReadingArticle && appOpenCount > 0 && appOpenCount % 20 == 0) {
      //         WidgetsBinding.instance.addPostFrameCallback((_) {
      //           openReviewBottomSheet();
      //         });
      //         GetStorage().write(AppString.userReadingArticleKey, false);
      //       }
      //     }
      //   }
      // },
    );
  }
}
