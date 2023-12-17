import 'package:contacts/core/app_routes.dart';
import 'package:contacts/core/app_strings.dart';
import 'package:contacts/models/contacts_response_model.dart';
import 'package:contacts/pages/landing/landing_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade200,
          child: Stack(
            children: [
              Column(
                children: [
                  SafeArea(
                    child: Container(
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                        margin: const EdgeInsets.all(16),
                        child: TextField(
                          controller: controller.searchController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 16),
                            hintText: AppString.search.tr,
                            prefixIcon: const Icon(
                              Feather.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.clearSearch();
                              },
                              icon: const Icon(
                                Foundation.x_circle,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          onChanged: (string) {
                            controller.search(string);
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      AppString.appName.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(() => controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : controller.filteredContacts.isEmpty
                            ? Center(child: Text(AppString.noSearchResult.tr))
                            : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                itemBuilder: (BuildContext context, int index) {
                                  ContactsDataModel contact = controller.filteredContacts[index];
                                  return Material(
                                    elevation: 2,
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          Material(
                                            elevation: 2,
                                            shape: const CircleBorder(),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.pink.shade100,
                                                border: Border.all(color: Colors.white, width: 2),
                                              ),
                                              child: Text(
                                                '${contact.shortName}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              controller.highlight(
                                                  contact.name!,
                                                  const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  )),
                                              controller.highlight(
                                                  contact.email!,
                                                  const TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: controller.filteredContacts.length)),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.customWidget);
                      },
                      child: Text(AppString.customWidget.tr)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
