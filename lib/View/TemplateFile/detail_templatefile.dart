import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/TemplateFile/detail_templatefile_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTemplateFile extends StatelessWidget {
  DetailTemplateFile({super.key});

  final controller = Get.put(DetailTemplatefileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        scrolledUnderElevation: 0.0,
        shadowColor: AppColor.text1,
        title: Text(
          "Chi tiết file mẫu",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColor.primary,
                    strokeWidth: 2,
                  ))
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomField.titleForm(title: "Tên file mẫu"),
                          const SizedBox(width: 10),
                          Text(controller.detail.name ?? "--", style: TextStyle(),)
                        ],
                      )
                    ],
                  ),
          )),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  offset: const Offset(0, -4), // shadow hướng lên trên
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Obx(
              () => CustomButton.primary(
                text: "Xem file mẫu",
                onPressed: controller.isLoading.value ? null : () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
