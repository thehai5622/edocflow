import 'package:edocflow/Component/custom_button.dart';
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
      backgroundColor: AppColor.background,
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
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Container(
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColor.white,
                                              ),
                                              child: const Icon(Icons.person,
                                                  size: 180)),
                                    ),
                            )),
                      ))
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
