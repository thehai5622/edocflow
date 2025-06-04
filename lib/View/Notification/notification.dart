import 'package:edocflow/Controller/Notification/notification_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notification extends StatelessWidget {
  Notification({super.key});

  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        scrolledUnderElevation: 0.0,
        shadowColor: AppColor.text1,
        title: Text(
          "Thông báo",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}