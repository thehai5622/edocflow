import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Component/custom_listview.dart';
import 'package:edocflow/Controller/TemplateFile/upsert_templatefile_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class UpsertTemplateFile extends StatelessWidget {
  UpsertTemplateFile({super.key});

  final controller = Get.put(UpsertTFController());
  final _formKey = GlobalKey<FormState>();

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
          controller.title,
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(children: [
                const SizedBox(height: 10),
                Container(
                  color: AppColor.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      CustomField.titleForm(
                              title: "Tên field mẫu", isRequired: true)
                          .marginSymmetric(horizontal: 20),
                      CustomField.textFormfield(
                        controller: controller.name,
                        hintText: "Văn bản điều hành, tờ trình, ...",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập tên file mẫu';
                          }
                          return null;
                        },
                      ).marginSymmetric(horizontal: 16, vertical: 8),
                      CustomField.titleForm(title: "File mẫu", isRequired: true)
                          .marginSymmetric(horizontal: 20),
                      GestureDetector(
                        onTap: () {
                          Utils.getFilePicker().then((value) {
                            if (value != null) {
                              controller.isChangeFile = true;
                              controller.file.value = value;
                              value.length().then((data) {
                                controller.fileSize.value = "$data bytes";
                              });
                            }
                          });
                        },
                        child: Obx(
                          () => Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 17),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: AppColor.boder,
                                ),
                                color: controller.file.value.path != ""
                                    ? AppColor.white
                                    : AppColor.background),
                            child: controller.file.value.path != ""
                                ? Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/document.svg",
                                        fit: BoxFit.scaleDown,
                                        height: 32,
                                        width: 32,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              basename(
                                                  controller.file.value.path),
                                              style: TextStyle(
                                                color: AppColor.text1,
                                                fontSize:
                                                    DeviceHelper.getFontSize(
                                                        14),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              controller.fileSize.value,
                                              style: TextStyle(
                                                color: AppColor.text1,
                                                fontSize:
                                                    DeviceHelper.getFontSize(
                                                        14),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/document.svg",
                                        fit: BoxFit.scaleDown,
                                        height: 24,
                                        width: 24,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Chọn và tải lên file',
                                        style: TextStyle(
                                          color: AppColor.text1,
                                          fontSize:
                                              DeviceHelper.getFontSize(14),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      CustomField.titleForm(
                              title: "Loại file mẫu", isRequired: true)
                          .marginSymmetric(horizontal: 20),
                      CustomField.dropDownField(
                        context: context,
                        onTap: controller.initTTF,
                        funcGetAndSearch: controller.getTTFCollection,
                        controller: controller.ttfName,
                        searchController: controller.searchTTF,
                        enabled: true,
                        hintText: "Chọn loại file mẫu",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng chọn loại file mẫu";
                          }
                          return null;
                        },
                        child: Obx(
                          () => controller.isLoadingTTF.value == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: AppColor.primary,
                                  strokeWidth: 2,
                                ))
                              : CustomListView.show(
                                  itemCount: controller.ttfCollection.length,
                                  gap: 0,
                                  itemBuilder: (context, index) =>
                                      CustomListView.viewItem(
                                    onTap: () {
                                      if (controller.selectedTTFUUID !=
                                          controller
                                              .ttfCollection[index].uuid) {
                                        Get.back();
                                        controller.ttfName.text = controller
                                                .ttfCollection[index].name ??
                                            "--";
                                        controller.selectedTTFUUID = controller
                                                .ttfCollection[index].uuid ??
                                            "";
                                      }
                                    },
                                    title: controller.ttfCollection[index].name,
                                    isSelected: controller.selectedTTFUUID ==
                                        controller.ttfCollection[index].uuid,
                                  ),
                                ),
                        ),
                      ).marginSymmetric(horizontal: 20, vertical: 6),
                      CustomField.titleForm(
                              title: "Kiểu file", isRequired: true)
                          .marginSymmetric(horizontal: 20),
                      Row(
                        children: [
                          Obx(() => CustomField.radioButton(
                              label: "Dùng chung",
                              value: 1,
                              enabled: true,
                              groupValue: controller.type.value,
                              onChanged: (value) {
                                if (value != controller.type.value) {
                                  controller.type.value = value;
                                }
                              })),
                          const SizedBox(width: 20),
                          Obx(() => CustomField.radioButton(
                              label: "Cá nhân",
                              value: 0,
                              enabled: true,
                              groupValue: controller.type.value,
                              onChanged: (value) {
                                if (value != controller.type.value) {
                                  controller.type.value = value;
                                }
                              })),
                        ],
                      ).marginSymmetric(horizontal: 16, vertical: 8),
                      CustomField.titleForm(
                              title: "Trạng thái", isRequired: true)
                          .marginSymmetric(horizontal: 20),
                      Row(
                        children: [
                          Obx(() => CustomField.radioButton(
                              label: "Hoạt động",
                              value: 1,
                              enabled: true,
                              groupValue: controller.status.value,
                              onChanged: (value) {
                                if (value != controller.status.value) {
                                  controller.status.value = value;
                                }
                              })),
                          const SizedBox(width: 20),
                          Obx(() => CustomField.radioButton(
                              label: "Khóa",
                              value: 0,
                              enabled: true,
                              groupValue: controller.status.value,
                              onChanged: (value) {
                                if (value != controller.status.value) {
                                  controller.status.value = value;
                                }
                              })),
                        ],
                      ).marginSymmetric(horizontal: 16, vertical: 8),
                      CustomField.titleForm(title: "Ghi chú")
                          .marginSymmetric(horizontal: 20),
                      CustomField.textFormfield(
                        controller: controller.note,
                        hintText: "Được dùng cho ...",
                        minLines: 4,
                        maxLines: 4,
                      ).marginSymmetric(horizontal: 16, vertical: 8),
                    ],
                  ),
                )
              ]),
            ),
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
                  text: "Xác nhận",
                  onPressed: controller.isWaitSubmit.value
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (controller.file.value.path.isEmpty) {
                              Utils.showSnackBar(
                                  title: "Lỗi!",
                                  message: "File mẫu là bắt buộc!");
                              return;
                            }
                            controller.submit();
                          }
                        },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
