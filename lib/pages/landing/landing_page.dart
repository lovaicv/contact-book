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
      body: Container(
        color: Colors.grey.shade200,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Obx(() => TextField(
                      controller: controller.searchController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: AppString.password.tr,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.clearSearch();
                          },
                          icon: Icon(Foundation.x_circle),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppString.appName.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() => ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemBuilder: (BuildContext context, int index) {
                      ContactsDataModel contact = controller.filteredContacts[index];
                      return Material(
                        elevation: 2,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Material(
                                elevation: 2,
                                shape: CircleBorder(),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.pink.shade100,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Text(
                                    '${contact.shortName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${contact.name}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('${contact.email}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.filteredContacts.length)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
