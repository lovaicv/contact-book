import 'package:contacts/models/contacts_response_model.dart';
import 'package:contacts/services/api_service.dart';
import 'package:contacts/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageController extends GetxController {
  LandingPageController({required this.apiService});

  final ApiService apiService;
  List<ContactsDataModel> oriContacts = [];
  RxList filteredContacts = [].obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getAllContacts();
    super.onInit();
  }

  getAllContacts() async {
    ContactsResponseModel response = await apiService.getContacts();
    if (response.success != null &&
        response.success! &&
        response.status != null &&
        response.status!.code == '200' &&
        response.data != null) {
      for (var element in response.data!) {
        List<String>? a = element.name?.split(' ');
        if (a != null && a.length > 1) {
          element.shortName = a[0].substring(0, 1) + a[1].substring(0, 1);
        }
      }
      oriContacts.addAll(response.data!);
      oriContacts.sort((a, b) => a.name!.compareTo(b.name!));
      filteredContacts.addAll(oriContacts);
    }
    showLog('response $response');
  }

  clearSearch() {
    searchController.text = '';
    filteredContacts.clear();
    filteredContacts.addAll(oriContacts);
  }
}
