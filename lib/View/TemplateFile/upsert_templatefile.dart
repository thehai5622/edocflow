import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Component/custom_listview.dart';
import 'package:edocflow/Controller/TemplateFile/upsert_templatefile_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      CustomField.titleForm(
                              title: "File mẫu", isRequired: true)
                          .marginSymmetric(horizontal: 20),
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
                                      title:
                                          controller.ttfCollection[index].name,
                                      isSelected: controller.selectedTTFUUID ==
                                          controller.ttfCollection[index].uuid,
                                    ),
                                  ),
                          ),
                        ).marginSymmetric(horizontal: 20, vertical: 6),
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
