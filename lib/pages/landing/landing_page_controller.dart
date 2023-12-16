import 'package:contacts/models/contacts_response_model.dart';
import 'package:contacts/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageController extends GetxController {
  LandingPageController({required this.apiService});

  final ApiService apiService;
  List<ContactsDataModel> oriContacts = [];
  RxList<ContactsDataModel> filteredContacts = <ContactsDataModel>[].obs;
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getAllContacts();
    super.onInit();
  }

  getAllContacts() async {
    ContactsResponseModel response = await apiService.getContacts();
    isLoading.value = false;
    if (response.success != null &&
        response.success! &&
        response.status != null &&
        response.status!.code == '200' &&
        response.data != null) {
      for (var element in response.data!) {
        List<String>? a = element.name?.split(' ');
        if (a != null && a.length > 1) {
          element.shortName = a[0].substring(0, 1) + a[1].substring(0, 1);
        } else if (a != null) {
          element.shortName = a[0].substring(0, 1);
        }
      }
      oriContacts.addAll(response.data!);
      oriContacts.sort((a, b) => a.name!.compareTo(b.name!));
      filteredContacts.addAll(oriContacts);
    }
  }

  clearSearch() {
    searchController.text = '';
    filteredContacts.clear();
    filteredContacts.addAll(oriContacts);
  }

  search(String searchText) {
    searchText = searchText.toLowerCase();
    filteredContacts.clear();
    filteredContacts
        .addAll(oriContacts.where((p0) => p0.name!.toLowerCase().contains(searchText) || p0.email!.toLowerCase().contains(searchText)));
  }

  highlight(String whichField, TextStyle textStyle) {
    final matches = searchController.text.allMatches(whichField.toLowerCase()).toList();
    List<TextSpan> nameSpan = [];
    if (matches.isEmpty) {
      nameSpan.add(TextSpan(text: whichField));
    } else {
      for (var i = 0; i < matches.length; i++) {
        final strStart = i == 0 ? 0 : matches[i - 1].end;
        final match = matches[i];
        nameSpan.add(TextSpan(text: whichField.substring(strStart, match.start)));
        nameSpan.add(TextSpan(text: whichField.substring(match.start, match.end), style: const TextStyle(color: Colors.blue)));
      }
      nameSpan.add(TextSpan(text: whichField.substring(matches.last.end)));
    }
    return RichText(text: TextSpan(style: textStyle, children: nameSpan));
  }
}
