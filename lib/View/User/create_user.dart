import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Component/custom_listview.dart';
import 'package:edocflow/Controller/User/create_user_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUser extends StatelessWidget {
  CreateUser({super.key});

  final controller = Get.put(CreateUserController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        shadowColor: AppColor.text1,
        title: Text(
          "Tạo thông tin cán bộ",
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
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    color: AppColor.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Utils.getImagePicker(2).then((value) {
                              if (value != null) {
                                controller.avatarLocal.value = value;
                              }
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Obx(
                              () => Image.file(
                                controller.avatarLocal.value,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColor.white,
                                  ),
                                  child: const Icon(Icons.person, size: 180),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomField.titleForm(
                                title: "Tên cán bộ", isRequired: true)
                            .marginSymmetric(horizontal: 20),
                        CustomField.textFormfield(
                          controller: controller.name,
                          maxLength: 75,
                          hintText: "Nguyễn Văn A",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên cán bộ';
                            }
                            return null;
                          },
                        ).marginSymmetric(horizontal: 20, vertical: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomField.titleForm(
                                title: "Giới tính", isRequired: true),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Obx(() => CustomField.radioButton(
                                    label: "Nam",
                                    value: 1,
                                    groupValue: controller.gender.value,
                                    onChanged: (value) {
                                      if (value != controller.gender.value) {
                                        controller.gender.value = value;
                                      }
                                    })),
                                const SizedBox(width: 20),
                                Obx(() => CustomField.radioButton(
                                    label: "Nữ",
                                    value: 0,
                                    groupValue: controller.gender.value,
                                    onChanged: (value) {
                                      if (value != controller.gender.value) {
                                        controller.gender.value = value;
                                      }
                                    })),
                              ],
                            ),
                          ],
                        ).marginSymmetric(horizontal: 20, vertical: 8),
                        CustomField.titleForm(title: "Quyền", isRequired: true)
                            .marginSymmetric(horizontal: 20),
                        CustomField.dropDownField(
                          context: context,
                          onTap: controller.initP,
                          funcGetAndSearch: controller.getPCollection,
                          controller: controller.pName,
                          searchController: controller.searchP,
                          enabled: true,
                          hintText: "Chọn quyền của cán bộ",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Quyền là trường bắt buộc";
                            }
                            return null;
                          },
                          child: Obx(
                            () => controller.isLoadingP.value == true
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: AppColor.primary,
                                    strokeWidth: 2,
                                  ))
                                : CustomListView.show(
                                    itemCount: controller.pCollection.length,
                                    gap: 0,
                                    itemBuilder: (context, index) =>
                                        CustomListView.viewItem(
                                      onTap: () {
                                        if (controller.selectedPUUID !=
                                            controller
                                                .pCollection[index].uuid) {
                                          Get.back();
                                          controller.pName.text = controller
                                                  .pCollection[index].name ??
                                              "--";
                                          controller.selectedPUUID = controller
                                                  .pCollection[index].uuid ??
                                              -1;
                                        }
                                      },
                                      title: controller.pCollection[index].name,
                                      isSelected: controller.selectedPUUID ==
                                          controller.pCollection[index].uuid,
                                    ),
                                  ),
                          ),
                        ).marginSymmetric(horizontal: 20, vertical: 6),
                        CustomField.titleForm(
                                title: "Thuộc cơ quan", isRequired: true)
                            .marginSymmetric(horizontal: 20),
                        CustomField.dropDownField(
                          context: context,
                          onTap: controller.initIA,
                          funcGetAndSearch: controller.getIACollection,
                          controller: controller.iaName,
                          searchController: controller.searchIA,
                          enabled: true,
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
                                            controller
                                                .iaCollection[index].uuid) {
                                          Get.back();
                                          controller.iaName.text = controller
                                                  .iaCollection[index].name ??
                                              "--";
                                          controller.selectedIAUUID = controller
                                                  .iaCollection[index].uuid ??
                                              "";
                                        }
                                      },
                                      title:
                                          controller.iaCollection[index].name,
                                      isSelected: controller.selectedIAUUID ==
                                          controller.iaCollection[index].uuid,
                                    ),
                                  ),
                          ),
                        ).marginSymmetric(horizontal: 20, vertical: 6),
                        CustomField.titleForm(title: "Ngày sinh")
                            .marginSymmetric(horizontal: 20),
                        CustomField.dateField(
                          enabled: true,
                          context: context,
                          controller: controller.birthDay,
                        ).marginSymmetric(horizontal: 20, vertical: 8),
                        CustomField.titleForm(
                                title: "Điện thoại liên hệ", isRequired: true)
                            .marginSymmetric(horizontal: 20),
                        CustomField.textFormfield(
                          controller: controller.phone,
                          maxLength: 10,
                          hintText: "0987654321",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số diện thoại';
                            }
                            return null;
                          },
                        ).marginSymmetric(horizontal: 20, vertical: 8),
                        CustomField.titleForm(title: "Email")
                            .marginSymmetric(horizontal: 20),
                        CustomField.textFormfield(
                          controller: controller.email,
                          maxLength: 75,
                          hintText: "witty@example.com",
                        ).marginSymmetric(horizontal: 20, vertical: 8),
                      ],
                    ),
                  )
                ],
              ),
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
