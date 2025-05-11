import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Component/custom_listview.dart';
import 'package:edocflow/Controller/IssuingAuthority/edit_ia_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditIssuingAuthority extends StatelessWidget {
  EditIssuingAuthority({super.key});

  final controller = Get.put(EditIssuingAuthorityController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        leading: GestureDetector(
            onTap: () => controller.back(),
            child: Icon(Icons.close, color: AppColor.text1, size: 21)),
        shadowColor: AppColor.text1,
        title: Text(
          "Chỉnh sửa cơ quan ban hành",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    color: AppColor.main,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        _titleForm(
                                title: "Tên cơ quan ban hành", isRequired: true)
                            .marginSymmetric(horizontal: 20),
                        CustomField.textFormfield(
                          controller: controller.name,
                          enabled: true,
                          hintText: 'Nhập tên cơ quan ban hành',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập tên cơ quan ban hành";
                            }
                            return null;
                          },
                        ).marginSymmetric(horizontal: 20, vertical: 6),
                        _titleForm(title: "Cấp hành chính", isRequired: true)
                            .marginSymmetric(horizontal: 20),
                        CustomField.dropDownField(
                          context: context,
                          onTap: controller.initAL,
                          funcGetAndSearch: controller.getALCollection,
                          controller: controller.aLName,
                          searchController: controller.searchAL,
                          enabled: true,
                          hintText: "Chọn cấp hành chính",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng chọn cấp hành chính";
                            }
                            return null;
                          },
                          child: Obx(
                            () => controller.isLoadingAL.value == true
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: AppColor.primary,
                                    strokeWidth: 2,
                                  ))
                                : CustomListView.show(
                                    itemCount: controller.aLCollection.length,
                                    gap: 0,
                                    itemBuilder: (context, index) =>
                                        CustomListView.viewItem(
                                      onTap: () {
                                        if (controller.selectedALUUID !=
                                            controller
                                                .aLCollection[index].uuid) {
                                          Get.back();
                                          controller.aLName.text = controller
                                                  .aLCollection[index].name ??
                                              "--";
                                          controller.selectedALUUID = controller
                                                  .aLCollection[index].uuid ??
                                              -1;
                                        }
                                      },
                                      title:
                                          controller.aLCollection[index].name,
                                      isSelected: controller.selectedALUUID ==
                                          controller.aLCollection[index].uuid,
                                    ),
                                  ),
                          ),
                        ).marginSymmetric(horizontal: 20, vertical: 6),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.main,
              ),
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.isWaitSubmit.value
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            controller.submit();
                          }
                        },
                  child: Text(
                    'Lưu lại',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DeviceHelper.getFontSize(14),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _titleForm({
    required String title,
    isRequired = false,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: DeviceHelper.getFontSize(16),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF535763),
            ),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(
                fontSize: DeviceHelper.getFontSize(15),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF0000),
              ),
            )
        ],
      ),
    );
  }
}
