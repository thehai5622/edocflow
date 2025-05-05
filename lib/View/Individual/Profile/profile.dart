import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/Individual/Profile/profile_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final controller = Get.put(ProfileController());
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
          "Thông tin cá nhân",
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
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        if (!controller.isEdit.value) {
                          return;
                        }
                        Utils.getImagePicker(2).then((value) {
                          if (value != null) {
                            controller.avatarLocal.value = value;
                          }
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Obx(
                          () => controller.avatarLocal.value.path != ""
                              ? Image.file(
                                  controller.avatarLocal.value,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "${controller.baseUrl}${controller.avatar.value}",
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
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => CustomField.textFormfield(
                        controller: controller.name,
                        enabled: controller.isEdit.value,
                        label: "Tên",
                        hintText: "Nguyễn Văn A",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập tên!';
                          }
                          return null;
                        }).marginSymmetric(horizontal: 16, vertical: 8),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Giới tính",
                          style: CustomField.labelStyle,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(() => CustomField.radioButton(
                          label: "Nam",
                          enabled: controller.isEdit.value,
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
                          enabled: controller.isEdit.value,
                          value: 0,
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            if (value != controller.gender.value) {
                              controller.gender.value = value;
                            }
                          })),
                    ],
                  ).marginSymmetric(horizontal: 16, vertical: 8),
                  Obx(
                    () => CustomField.dateField(
                            context: context,
                            controller: controller.birthDay,
                            enabled: controller.isEdit.value,
                            label: "Ngày sinh")
                        .marginSymmetric(horizontal: 16, vertical: 8),
                  ),
                  Obx(
                    () => CustomField.textFormfield(
                        controller: controller.phone,
                        enabled: controller.isEdit.value,
                        keyboardType: TextInputType.number,
                        label: "Số điện thoại",
                        hintText: "09876543231",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập SĐT liên hệ!';
                          }
                          return null;
                        }).marginSymmetric(horizontal: 16, vertical: 8),
                  ),
                  Obx(
                    () => CustomField.textFormfield(
                      controller: controller.email,
                      enabled: controller.isEdit.value,
                      label: "Email",
                      hintText: "abc@xyz.com",
                    ).marginSymmetric(horizontal: 16, vertical: 8),
                  ),
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
                () => !controller.isEdit.value
                    ? CustomButton.primary(
                        text: "Chỉnh sửa",
                        onPressed: () => controller.isEdit.value = true)
                    : Row(
                        children: [
                          Expanded(
                              child: CustomButton.cancel(
                                  text: 'Hủy bỏ',
                                  onPressed: () => controller.cancel())),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomButton.primary(
                              text: "Lưu lại",
                              onPressed: controller.isWaitSubmit.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        controller.submit();
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
