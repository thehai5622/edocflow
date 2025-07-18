import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Component/custom_listview.dart';
import 'package:edocflow/Controller/Document/upsert_document_out_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpsertDocumentOut extends StatelessWidget {
  UpsertDocumentOut({super.key});

  final controller = Get.put(UpsertDocumentOutController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
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
                    CustomField.titleForm(title: "Số hiệu", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.textFormfield(
                      controller: controller.referenceNumber,
                      hintText: "X/2024/NĐ-CP",
                      maxLength: 20,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Số hiệu văn bản là bắt buộc';
                        }
                        return null;
                      },
                    ).marginSymmetric(horizontal: 16, vertical: 8),
                    CustomField.titleForm(title: "Tới cơ quan ban hành")
                        .marginSymmetric(horizontal: 20),
                    CustomField.dropDownField(
                      context: context,
                      onTap: controller.initIA,
                      funcGetAndSearch: controller.getIACollection,
                      controller: controller.iaName,
                      searchController: controller.searchIA,
                      enabled: controller.uuid == "",
                      hintText: "Chọn cơ quan ban hành",
                      child: Obx(
                        () => controller.isLoadingIA.value == true
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColor.primary,
                                strokeWidth: 2,
                              ))
                            : CustomListView.show(
                                itemCount: controller.iaCollection.length,
                                gap: 0,
                                itemBuilder: (context, index) =>
                                    CustomListView.viewItem(
                                  onTap: () {
                                    if (controller.selectedIAUUID !=
                                        controller.iaCollection[index].uuid) {
                                      Get.back();
                                      controller.iaName.text =
                                          controller.iaCollection[index].name ??
                                              "--";
                                      controller.selectedIAUUID =
                                          controller.iaCollection[index].uuid ??
                                              "";
                                    }
                                  },
                                  title: controller.iaCollection[index].name,
                                  isSelected: controller.selectedIAUUID ==
                                      controller.iaCollection[index].uuid,
                                ),
                              ),
                      ),
                    ).marginSymmetric(horizontal: 20, vertical: 6),
                    CustomField.titleForm(title: "Trích yếu", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.textFormfield(
                      controller: controller.summary,
                      hintText:
                          "Hiện nay, tình hình thương mại quốc tế diễn biến rất nhanh và khó lường ...",
                      maxLength: 75,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên File';
                        }
                        return null;
                      },
                    ).marginSymmetric(horizontal: 16, vertical: 8),
                    CustomField.titleForm(title: "File", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.dropDownField(
                      context: context,
                      onTap: controller.initTF,
                      funcGetAndSearch: controller.getTFCollection,
                      controller: controller.tfName,
                      searchController: controller.searchTF,
                      enabled: true,
                      hintText: "Chọn File",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng chọn File";
                        }
                        return null;
                      },
                      child: Obx(
                        () => controller.isLoadingTF.value == true
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColor.primary,
                                strokeWidth: 2,
                              ))
                            : CustomListView.show(
                                itemCount: controller.tfCollection.length,
                                gap: 0,
                                itemBuilder: (context, index) =>
                                    CustomListView.viewItem(
                                  onTap: () {
                                    if (controller.selectedTFUUID !=
                                        controller.tfCollection[index].uuid) {
                                      Get.back();
                                      controller.tfName.text =
                                          controller.tfCollection[index].name ??
                                              "--";
                                      controller.selectedTFUUID =
                                          controller.tfCollection[index].uuid ??
                                              "";
                                    }
                                  },
                                  title: controller.tfCollection[index].name,
                                  isSelected: controller.selectedTFUUID ==
                                      controller.tfCollection[index].uuid,
                                ),
                              ),
                      ),
                    ).marginSymmetric(horizontal: 20, vertical: 6),
                    CustomField.titleForm(title: "Lĩnh vực", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.dropDownField(
                      context: context,
                      onTap: controller.initF,
                      funcGetAndSearch: controller.getFCollection,
                      controller: controller.fName,
                      searchController: controller.searchF,
                      enabled: true,
                      hintText: "Chọn lĩnh vực",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng chọn lĩnh vực";
                        }
                        return null;
                      },
                      child: Obx(
                        () => controller.isLoadingF.value == true
                            ? Center(
                                child: CircularProgressIndicator(
                                color: AppColor.primary,
                                strokeWidth: 2,
                              ))
                            : CustomListView.show(
                                itemCount: controller.fCollection.length,
                                gap: 0,
                                itemBuilder: (context, index) =>
                                    CustomListView.viewItem(
                                  onTap: () {
                                    if (controller.selectedFUUID !=
                                        controller.fCollection[index].uuid) {
                                      Get.back();
                                      controller.fName.text =
                                          controller.fCollection[index].name ??
                                              "--";
                                      controller.selectedFUUID =
                                          controller.fCollection[index].uuid ??
                                              "";
                                    }
                                  },
                                  title: controller.fCollection[index].name,
                                  isSelected: controller.selectedFUUID ==
                                      controller.fCollection[index].uuid,
                                ),
                              ),
                      ),
                    ).marginSymmetric(horizontal: 20, vertical: 6),
                    CustomField.titleForm(
                            title: "Ngày phát hành", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.dateField(
                        context: context,
                        controller: controller.release,
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ngày phát hành là bắt buộc';
                          }
                          return null;
                        }).marginSymmetric(horizontal: 16, vertical: 8),
                    CustomField.titleForm(
                            title: "Nơi lưu bản chính", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.textFormfield(
                      controller: controller.originalLocation,
                      hintText: "Kho hành chính...",
                      maxLength: 75,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập nơi lưu lại bản chính';
                        }
                        return null;
                      },
                    ).marginSymmetric(horizontal: 16, vertical: 8),
                    CustomField.titleForm(
                            title: "Số bản phát hành", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.textFormfield(
                      controller: controller.numberReleases,
                      keyboardType: TextInputType.number,
                      hintText: "12",
                      maxLength: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số bản phát hành';
                        }
                        return null;
                      },
                    ).marginSymmetric(horizontal: 16, vertical: 8),
                    CustomField.titleForm(
                            title: "Mức độ khẩn", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.dropdownButton(
                      hint: "Chọn mức độ khẩn",
                      value: controller.urgencyLevel.value,
                      items: [
                        {"value": "0", "label": "Bình thường"},
                        {"value": "1", "label": "Hỏa tốc"},
                        {"value": "2", "label": "Thượng khẩn"},
                        {"value": "3", "label": "Khẩn"},
                      ],
                      onChanged: (value) {
                        controller.urgencyLevel.value = value ?? "0";
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Yêu cầu có mức độ khẩn';
                        }
                        return null;
                      },
                    ).marginSymmetric(horizontal: 16, vertical: 8),
                    CustomField.titleForm(
                            title: "Mức độ bảo mật", isRequired: true)
                        .marginSymmetric(horizontal: 20),
                    CustomField.dropdownButton(
                      hint: "Chọn mức độ bảo mật",
                      value: controller.confidentialityLevel.value,
                      items: [
                        {"value": "0", "label": "Bình thường"},
                        {"value": "1", "label": "Tuyệt mật-A"},
                        {"value": "2", "label": "Tối mật-B"},
                        {"value": "3", "label": "Mật-C"},
                      ],
                      onChanged: (value) {
                        controller.confidentialityLevel.value = value ?? "0";
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Yêu cầu có mức độ bảo mật';
                        }
                        return null;
                      },
                    ).marginSymmetric(horizontal: 16, vertical: 8),
                  ],
                ),
              )
            ])),
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
                      : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await controller.submit();
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
