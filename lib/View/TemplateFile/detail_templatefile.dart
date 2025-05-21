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
                      _detailValue(
                              value: controller.detail.name, isHightlight: true)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Loại file mẫu:"),
                      _detailValue(
                              value: controller.detail.typeTemplateFile?.name)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Kiểu file:"),
                      _detailValue(
                              value: controller.detail.type == 1
                                  ? "Dùng chung"
                                  : "Cá nhân")
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Trạng thái:"),
                      _detailValue(
                              value: controller.detail.type == 1
                                  ? "Hoạt động"
                                  : "Bị khóa")
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Ghi chú:"),
                      _detailValue(value: controller.detail.note)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Ngày tạo:"),
                      _detailValue(
                              value:
                                  Utils.formatDate(controller.detail.createdAt))
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Chỉnh sửa lần cuối:"),
                      _detailValue(
                              value:
                                  Utils.formatDate(controller.detail.updatedAt))
                          .marginSymmetric(vertical: 8, horizontal: 16),
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
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        Utils.openFile(controller.detail.file ?? "");
                      },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _detailValue({String? value, bool isHightlight = false}) {
    return Text(
      value ?? "--",
      style: TextStyle(
        fontSize: DeviceHelper.getFontSize(15),
        color: isHightlight ? AppColor.primary : AppColor.text1,
        fontWeight: isHightlight ? FontWeight.w600 : FontWeight.w500,
      ),
    );
  }
}
