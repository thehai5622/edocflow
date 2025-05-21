import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/Document/detail_document_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Global/confidentiality_level.dart';
import 'package:edocflow/Global/document_status.dart';
import 'package:edocflow/Global/urgency_level.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailDocument extends StatelessWidget {
  DetailDocument({super.key});

  final controller = Get.put(DetailDocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        shadowColor: AppColor.text1,
        title: Text(
          "Chi tiết văn bản",
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
                          CustomField.titleForm(title: "Trạng thái:"),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: DocumentStatus.getColorStatus(
                                controller.detail.status ?? 0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _detailValue(
                              value: DocumentStatus.getTextStatus(
                                controller.detail.status ?? 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomField.titleForm(title: "Mã văn bản:"),
                      _detailValue(
                        value: controller.detail.uuid,
                        isHightlight: true,
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Mức độ khẩn:"),
                      _detailValue(
                        value: UrgencyLevel.getUrgencyLevel(
                          controller.detail.urgencyLevel ?? 0,
                        )
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Mức độ bảo mật:"),
                      _detailValue(
                        value: ConfidentialityLevel.getConfidentialityLevel(
                          controller.detail.confidentialityLevel ?? 0,
                        )
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Trích yếu:"),
                      _detailValue(value: controller.detail.summary)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Năm phát hành:"),
                      _detailValue(value: "${controller.detail.year}")
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Số bản phát hành:"),
                      _detailValue(value: "${controller.detail.numberReleases}")
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Nơi lưu trữ bản chính:"),
                      _detailValue(value: controller.detail.originalLocation)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Người tạo:"),
                      _detailValue(value: controller.detail.user?.name)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Từ cơ quan:"),
                      _detailValue(
                        value: controller.detail.fromIssuingauthority?.name,
                        isHightlight: true,
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Người ký/Người duyệt:"),
                      _detailValue(value: controller.detail.usersign?.name)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Tới cơ quan:"),
                      _detailValue(
                        value: controller.detail.issuingauthority?.name,
                        isHightlight: true,
                      ).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Ngày tạo:"),
                      _detailValue(
                          value: Utils.formatDate(
                        controller.detail.createdAt,
                      )).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Chỉnh sửa lần cuối:"),
                      _detailValue(
                          value: Utils.formatDate(
                        controller.detail.updatedAt,
                      )).marginSymmetric(vertical: 8, horizontal: 16),
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
                text: "Xem chi tiết file",
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        // Utils.openFile(controller.detail.file ?? "");
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
