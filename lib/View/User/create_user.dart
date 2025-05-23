import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_field.dart';
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
                          hintText: "Nguyễn Văn A",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên cán bộ';
                            }
                            return null;
                          },
                        ).marginSymmetric(horizontal: 16, vertical: 8),
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
                        ).marginSymmetric(horizontal: 16, vertical: 8),
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
