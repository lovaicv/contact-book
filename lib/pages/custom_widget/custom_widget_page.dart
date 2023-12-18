import 'package:contacts/core/app_strings.dart';
import 'package:contacts/models/prospect_model.dart';
import 'package:contacts/pages/custom_widget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomWidgetPage extends StatelessWidget {
  @override
  const CustomWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text(AppString.customWidget.tr),
        ),
        body: CustomWidget(data: [
          ProspectModel(AppString.cold.tr, 40, Colors.blue),
          ProspectModel(AppString.hot.tr, 80, Colors.red),
          ProspectModel(AppString.warm.tr, 40, Colors.orange),
        ], height: 130.0));
  }
}