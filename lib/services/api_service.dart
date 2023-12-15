import 'dart:convert';
import 'dart:io';

import 'package:contacts/core/app_url.dart';
import 'package:contacts/models/contacts_response_model.dart';
import 'package:contacts/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;

class ApiService extends GetxService {
  final Dio dio = Dio();
  int timeout = 30;

  @override
  onInit() {
    showLog('initApiService');
    initApiService();
    super.onInit();
  }

  initApiService() {
    dio.options.baseUrl = AppUrl.baseUrl;
    dio.options.connectTimeout = Duration(seconds: timeout);
    dio.options.receiveTimeout = Duration(seconds: timeout);
    dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        logPrint: (log) {
          showLog(log);
        }));
    // dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) => requestInterceptor(options, handler),
      onResponse: (Response response, ResponseInterceptorHandler handler) => responseInterceptor(response, handler),
      onError: (DioException dioException, ErrorInterceptorHandler handler) => errorInterceptor(dioException, handler),
    ));
  }

//todo put retry internet check here from my app bar
  dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    // // showLog('requestInterceptor ${options.uri}');
    // // var accessToken = options.uri.toString() == '${Config.getBaseUrl()}${Config.landingMaintenance}'
    // //     ? Constant.getMaintenanceToken()
    // //     : userDB().userAccessToken;
    // var accessToken = userDb.getUser().accessToken;
    // // var accessToken =
    // // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbmV3c3dhdi5jb20iLCJhdWQiOiJudy1jbGllbnQiLCJpYXQiOjE2OTYzMDY2MzgsImV4cCI6MTg4MjkzMDYzOCwicHJfaWQiOiJhXzIzMzM1ODUiLCJzZGsiOiJmaSIsIm53X2lkIjoxNzU0NjUsImZpX2lkIjoiTWFNTUJ6MG5XaFFxRHVlV2R3bmtPcFJhVHhDMyIsInVfaWQiOiIzNzM2NTE3In0.7AjOjOKR4ob326bbbrQDJP-D4vjoa85B8fflo0USOzc';
    // //todo what is the difference?
    // options.headers.addAll({
    //   'Authorization': 'Bearer $accessToken',
    //   'nwtoken': accessToken,
    //   'platform': GetPlatform.isAndroid ? 'android' : 'ios',
    //   'AdPreviewCode': GetStorage().read(AppString.adPreviewCodeKey) ?? '',
    // });
    // showLog('headers ${options.headers}');
    return handler.next(options);
  }

//used to check response header for validation
  dynamic responseInterceptor(Response response, ResponseInterceptorHandler handler) async {
    // showLog('responseInterceptor ${response.requestOptions.uri}');
    return handler.next(response);
  }

//  String csrfToken; //top-level variable
  dynamic errorInterceptor(DioException dioError, ErrorInterceptorHandler handler) async {
    // showLog('errorInterceptor ${dioError.requestOptions.uri} $dioError');
//     if (dioError.response?.statusCode == 401 &&
//         dioError.requestOptions.uri.toString() != '${Config.getBaseUrl()}${Config.landingMaintenance}') {
//       RequestOptions options = dioError.response.requestOptions;
//       // If the token has been updated, repeat directly.
// //      if (csrfToken != options.headers["csrfToken"]) {
// //        options.headers["csrfToken"] = csrfToken;
// //        //repeat
// //        return dio.request(options.path, options: options);
// //      }
//       // update token and repeat
//       // Lock to block the incoming request until the token updated
//       //=================================================================
//       dio.interceptors.requestLock.lock();
//       dio.interceptors.responseLock.lock();
//       showLog('errorInterceptor token invalid try refresh token');
//       return tokenRepository.refreshToken().then((TokenResponseModel response) {
//         //update csrfToken
//         userDB()
//           ..userAccessToken = response.access_token
//           ..userRefreshToken = response.refresh_token
//           ..save();
//         options.headers["Authorization"] = "Bearer ${response.access_token}";
//       }).whenComplete(() {
//         showLog('errorInterceptor refresh whenComplete');
//         dio.interceptors.requestLock.unlock();
//         dio.interceptors.responseLock.unlock();
//       }).then((e) async {
//         //repeat
//         showLog('errorInterceptor refresh then $e');
//         dio.fetch(options).then(handler.resolve).catchError((e) => handler.reject(e));
//         // Response response = await dio.request(
//         //   options.path,
//         //   options: dioError.requestOptions.op,
//         // );
//         // return handler.resolve(response);
//       });
//       //=================================================================
//     } else if (_shouldRetry(dioError)) {
//       try {
//         showLog('errorInterceptor DioConnectivityRequestRetrier');
//         Response response = await DioConnectivityRequestRetrier(
//           dio: dio,
//           connectivity: Connectivity(),
//         ).scheduleRequestRetry(dioError.requestOptions);
//         return handler.resolve(response);
//       } catch (e) {
//         // Let any new error from the retrier pass through
//         showLog('errorInterceptor DioConnectivityRequestRetrier error $e');
//         return handler.reject(dioError);
//       }
//     }
//     showLog('errorInterceptor $dioError');
    return handler.reject(dioError);
  }

  bool _shouldRetry(DioException err) {
    showLog('err ${err.type}');
    return err.type == DioExceptionType.unknown && err.error != null && err.error is SocketException;
  }

  Future<ContactsResponseModel> getContacts() async {
    try {
      final response = await dio.get(AppUrl.getAllContacts);
      if (response.statusCode == 200) {
        return ContactsResponseModel.fromJson(jsonDecode(response.data));
      } else {
        DioException dioError = DioException(requestOptions: RequestOptions(path: response.requestOptions.path));
        dioError.response?.statusCode = response.statusCode;
        showErrorDialog(dioError);
        throw dioError;
      }
    } catch (error, stackTrace) {
      showLog('Exception: $error\n$stackTrace');
      // FirebaseCrashlytics.instance.recordError(error, stackTrace, reason: {'url': Config.productCategory});
      showErrorDialog(error);
      rethrow;
    }
  }

  showErrorDialog(dioError) {
    Get.dialog(AlertDialog(
      content: Text('$dioError'),
    ));
  }
}
