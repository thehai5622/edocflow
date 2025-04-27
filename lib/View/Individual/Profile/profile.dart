import 'package:edocflow/Controller/Individual/Profile/profile_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        shadowColor: AppColor.text1,
        title: Text(
          "Thông tin cá nhân",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                height: Get.width * 0.2,
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  "${controller.baseUrl}${controller.avatar.value}",
                  height: Get.width * 0.2,
                  width: Get.width * 0.2,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.person, size: Get.width * 0.2),
                ),
              ))
        ],
      ),
    );
  }
}
