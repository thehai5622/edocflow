import 'package:edocflow/Controller/Individual/ChangePass/changepass_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangePass extends StatelessWidget {
  ChangePass({super.key});

  final controller = Get.put(ChangePassController());
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
          "Đổi mật khẩu",
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
                  const SizedBox(height: 4),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _labelForm(label: "Mật khẩu hiện tại", isRequired: true)
                            .marginSymmetric(vertical: 6),
                        Obx(
                          () => TextFormField(
                            style: TextStyle(
                              fontSize: DeviceHelper.getFontSize(14),
                              fontWeight: FontWeight.w700,
                              color: AppColor.text1,
                            ),
                            controller: controller.oldPassword,
                            obscureText: controller.isHidePass.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              hintStyle: TextStyle(
                                fontSize: DeviceHelper.getFontSize(14),
                                fontWeight: FontWeight.w700,
                                color: AppColor.textHint,
                              ),
                              hintText: 'Nhập mật khẩu hiện tại',
                              contentPadding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.isHidePass.value =
                                      !controller.isHidePass.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    controller.isHidePass.value
                                        ? 'assets/icons/eye_slash.svg'
                                        : 'assets/icons/eye.svg',
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng nhập mật khẩu hiện tại";
                              }
                              return null;
                            },
                          ),
                        ),
                        _labelForm(label: "Mật khẩu mới", isRequired: true)
                            .marginSymmetric(vertical: 6),
                        Obx(
                          () => TextFormField(
                            style: TextStyle(
                              fontSize: DeviceHelper.getFontSize(14),
                              fontWeight: FontWeight.w700,
                              color: AppColor.text1,
                            ),
                            controller: controller.newPassword,
                            obscureText: controller.isHideNew.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              hintStyle: TextStyle(
                                fontSize: DeviceHelper.getFontSize(14),
                                fontWeight: FontWeight.w700,
                                color: AppColor.textHint,
                              ),
                              hintText: 'Nhập mật khẩu mới',
                              contentPadding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.isHideNew.value =
                                      !controller.isHideNew.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    controller.isHideNew.value
                                        ? 'assets/icons/eye_slash.svg'
                                        : 'assets/icons/eye.svg',
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng nhập mật khẩu mới";
                              } else if (value.length < 6) {
                                return "Tối thiểu 6 ký tự";
                              }
                              return null;
                            },
                          ),
                        ),
                        _labelForm(label: "Xác nhận mật khẩu", isRequired: true)
                            .marginSymmetric(vertical: 6),
                        Obx(
                          () => TextFormField(
                            style: TextStyle(
                              fontSize: DeviceHelper.getFontSize(14),
                              fontWeight: FontWeight.w700,
                              color: AppColor.text1,
                            ),
                            controller: controller.confirmNewPassword,
                            obscureText: controller.isHideConfirm.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    BorderSide(width: 1, color: AppColor.boder),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              hintStyle: TextStyle(
                                fontSize: DeviceHelper.getFontSize(14),
                                fontWeight: FontWeight.w700,
                                color: AppColor.textHint,
                              ),
                              hintText: 'Nhập xác nhận mật khẩu mới',
                              contentPadding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.isHideConfirm.value =
                                      !controller.isHideConfirm.value;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    controller.isHideConfirm.value
                                        ? 'assets/icons/eye_slash.svg'
                                        : 'assets/icons/eye.svg',
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng nhập xác nhận mật khẩu mới";
                              } else if (value != controller.newPassword.text) {
                                return "Mật khẩu mới và xác thực mật khẩu mới không khớp";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -4),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ],
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
                      fontSize: DeviceHelper.getFontSize(15),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
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

  Row _labelForm({required String label, bool isRequired = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(16),
            fontWeight: FontWeight.w700,
            color: AppColor.text1,
          ),
        ),
        const SizedBox(width: 4),
        if (isRequired)
          Text(
            "*",
            style: TextStyle(
              fontSize: DeviceHelper.getFontSize(16),
              fontWeight: FontWeight.w700,
              color: AppColor.red,
            ),
          ),
      ],
    );
  }
}
