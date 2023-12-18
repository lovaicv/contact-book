import 'dart:math' as math;

import 'package:contacts/core/app_strings.dart';
import 'package:contacts/models/prospect_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomWidget extends StatelessWidget {
  final List<ProspectModel> data;
  final double height;

  @override
  const CustomWidget({super.key, required this.data, required this.height});

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var element in data) {
      total += element.amount!;
    }
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  AppString.prospectByStatus.tr,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.green,
                      width: height,
                      height: height,
                      margin: const EdgeInsets.only(top: 18),
                      child: CustomPaint(
                        painter: _MultipleColorCirclePainter(
                          data: data,
                          height: height / 2,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$total',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              AppString.totalProspects.tr,
                              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data
                          .map((e) => Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        color: e.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text('${e.name}'),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data
                          .map((e) => Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '${e.amount}',
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${(e.amount! / total * 100).round()}%',
                                      style: TextStyle(color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ]),
            )),
      ),
    );
  }
}

class _MultipleColorCirclePainter extends CustomPainter {
  final List<ProspectModel> data;
  final double height;

  @override
  _MultipleColorCirclePainter({required this.data, required this.height});

  double pi = math.pi;

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 7;
    Rect myRect = Rect.fromCircle(center: Offset(height, height), radius: height);

    double radianStart = 0;
    double radianLength = 0;
    int allOccurrences = 0;
    for (var element in data) {
      allOccurrences += element.amount!;
    }
    for (var element in data) {
      double percent = element.amount! / allOccurrences;
      radianLength = 2 * percent * math.pi;
      canvas.drawArc(
          myRect,
          radianStart,
          radianLength,
          false,
          Paint()
            ..color = element.color!
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke);
      radianStart += radianLength;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
