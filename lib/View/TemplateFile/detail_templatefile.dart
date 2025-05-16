import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/TemplateFile/detail_templatefile_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
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
                      CustomField.titleForm(title: "Tên file mẫu:"),
                      Text(
                        controller.detail.name ?? "--",
                        style: TextStyle(
                          fontSize: DeviceHelper.getFontSize(16),
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Loại file mẫu:"),
                      Text(
                        controller.detail.typeTemplateFile?.name ?? "--",
                        style: TextStyle(
                          fontSize: DeviceHelper.getFontSize(15),
                          color: AppColor.text1,
                          fontWeight: FontWeight.w500,
                        ),
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Kiểu file:"),
                      Text(
                        controller.detail.type == 1 ? "Dùng chung" : "Cá nhân",
                        style: TextStyle(
                          fontSize: DeviceHelper.getFontSize(15),
                          color: AppColor.text1,
                          fontWeight: FontWeight.w500,
                        ),
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Trạng thái:"),
                      Text(
                        controller.detail.type == 1 ? "Hoạt động" : "Bị khóa",
                        style: TextStyle(
                          fontSize: DeviceHelper.getFontSize(15),
                          color: AppColor.text1,
                          fontWeight: FontWeight.w500,
                        ),
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Ghi chú:"),
                      Text(
                        controller.detail.note ?? "--",
                        style: TextStyle(
                          fontSize: DeviceHelper.getFontSize(15),
                          color: AppColor.text1,
                          fontWeight: FontWeight.w500,
                        ),
                      ).marginSymmetric(vertical: 8, horizontal: 16),
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
                onPressed: controller.isLoading.value ? null : () {
                  Utils.openFile(controller.detail.file ?? "");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
