import 'dart:convert';

import 'package:contacts/core/app_url.dart';
import 'package:contacts/models/contacts_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;

class ApiService extends GetxService {
  final Dio dio = Dio();
  int timeout = 30;

  @override
  onInit() {
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
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) => requestInterceptor(options, handler),
      onResponse: (Response response, ResponseInterceptorHandler handler) => responseInterceptor(response, handler),
      onError: (DioException dioException, ErrorInterceptorHandler handler) => errorInterceptor(dioException, handler),
    ));
  }

  dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  dynamic responseInterceptor(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  dynamic errorInterceptor(DioException dioError, ErrorInterceptorHandler handler) async {
    return handler.reject(dioError);
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
