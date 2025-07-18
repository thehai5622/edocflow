import 'package:edocflow/Component/custom_bottomsheet.dart';
import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_dialog.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/Document/detail_document_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Global/confidentiality_level.dart';
import 'package:edocflow/Global/document_status.dart';
import 'package:edocflow/Global/urgency_level.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/time_helper.dart';
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: DocumentStatus.getColorStatus(
                                controller.detail.status ?? 0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _detailValue(
                              isStatus: true,
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
                      )).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Mức độ bảo mật:"),
                      _detailValue(
                          value: ConfidentialityLevel.getConfidentialityLevel(
                        controller.detail.confidentialityLevel ?? 0,
                      )).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Trích yếu:"),
                      _detailValue(value: controller.detail.summary)
                          .marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Ngày phát hành:"),
                      _detailValue(
                              value: TimeHelper.convertDateFormat(
                                  controller.detail.release, false))
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
                        isoString: controller.detail.createdAt,
                      )).marginSymmetric(vertical: 8, horizontal: 16),
                      CustomField.titleForm(title: "Chỉnh sửa lần cuối:"),
                      _detailValue(
                          value: Utils.formatDate(
                        isoString: controller.detail.updatedAt,
                      )).marginSymmetric(vertical: 8, horizontal: 16),
                    ],
                  ),
          )),
          Obx(
            () => controller.isLoading.value
                ? const SizedBox(height: 0)
                : Container(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton.cancel(
                            text: "Xem chi tiết file",
                            onPressed: () {
                              Get.toNamed(Routes.detailTemplateFile,
                                  arguments: {
                                    "uuid": controller.detail.templatefile?.uuid
                                  });
                            },
                          ),
                        ),
                        if (controller.isIn &&
                            !(controller.detail.status == 5 ||
                                controller.detail.status == 4 ||
                                controller.detail.status == 3))
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomButton.primary(
                                    text: _getTextStatus(
                                        controller.detail.status),
                                    onPressed: () {
                                      if (controller.detail.status != 1) {
                                        controller.submit();
                                      }
                                      _reception(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _reception(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    CustomDialog.dialogEmpty(
        context: context,
        body: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chỉ định văn bản tới phòng ban",
                style: TextStyle(
                  fontSize: DeviceHelper.getFontSize(20),
                  color: AppColor.text1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              CustomField.titleForm(title: "Phòng ban", isRequired: true),
              CustomField.textFormfield(
                readOnly: true,
                controller: controller.departmentTC,
                hintText: "Chọn phòng ban",
                suffixIcon: const Icon(Icons.arrow_drop_down),
                onTap: () => _department(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phòng ban là bắt buộc";
                  }
                  return null;
                },
              ).marginOnly(top: 10, bottom: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.boder,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Hủy bỏ",
                        style: TextStyle(
                          fontSize: DeviceHelper.getFontSize(14),
                          color: AppColor.text1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                      ),
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Get.back();
                          controller.submit();
                        }
                      },
                      child: Text(
                        "Xác nhận",
                        style: TextStyle(
                          fontSize: DeviceHelper.getFontSize(14),
                          color: AppColor.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  _department(BuildContext context) {
    RxString selected = controller.selectedD.obs;
    CustomBottomsheet.show(
        context: context,
        child: SizedBox(
          height: Get.height * 0.3,
          width: Get.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.colectionD.length,
            itemBuilder: (context, index) {
              String? uuid = controller.colectionD[index].uuid ?? "--";
              String? name = controller.colectionD[index].name ?? "--";
              return GestureDetector(
                onTap: () {
                  if (selected.value != uuid) {
                    selected.value = uuid;
                    controller.selectedD = uuid;
                    controller.departmentTC.text = name;
                    Get.back();
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    width: 1,
                    color: AppColor.boder,
                  ))),
                  child: Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: DeviceHelper.getFontSize(15),
                              color: selected.value == uuid
                                  ? AppColor.primary
                                  : AppColor.text1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        selected.value == uuid
                            ? Icon(
                                Icons.check,
                                size: 20,
                                color: AppColor.primary,
                              )
                            : const SizedBox(height: 20, width: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  String _getTextStatus(int? status) {
    switch (status) {
      case 1:
        return "Tiếp nhận văn bản";
      case 2:
        return "Ký duyệt văn bản";
      default:
        return "";
    }
  }

  Text _detailValue(
      {String? value, bool isHightlight = false, bool isStatus = false}) {
    return Text(
      value ?? "--",
      style: TextStyle(
        fontSize: DeviceHelper.getFontSize(15),
        color: isStatus
            ? Colors.white
            : isHightlight
                ? AppColor.primary
                : AppColor.text1,
        fontWeight: isHightlight ? FontWeight.w600 : FontWeight.w500,
      ),
    );
  }
}
