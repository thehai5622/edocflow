import 'package:edocflow/Controller/Login/login_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.2,
                child: Center(
                  child: Text(
                    "Welcome back",
                    style: TextStyle(
                      fontSize: DeviceHelper.getFontSize(25),
                      color: AppColor.main,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.main,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(),
                      Column(
                        children: [
                          TextFormField(
                            controller: controller.usermame,
                            style: TextStyle(
                              fontSize: DeviceHelper.getFontSize(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: AppColor.text1,
                            ),
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              label: Text(
                                'Tài khoản',
                                style: TextStyle(
                                  fontSize: DeviceHelper.getFontSize(14),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ),
                              floatingLabelStyle: TextStyle(
                                fontSize: DeviceHelper.getFontSize(14),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                                color: AppColor.text1,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFE1E5ED)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFE1E5ED)),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              hintStyle: TextStyle(
                                color: const Color(0xFF777E90),
                                fontSize: DeviceHelper.getFontSize(14),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'nhập tài khoản',
                              contentPadding:
                                  const EdgeInsets.only(left: 16, right: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tài khoản không được để trống!';
                              }
                              return null;
                            },
                          ).marginSymmetric(horizontal: 20, vertical: 6),
                          TextFormField(
                            controller: controller.password,
                            style: TextStyle(
                              fontSize: DeviceHelper.getFontSize(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: AppColor.text1,
                            ),
                            autocorrect: false,
                            enableSuggestions: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              label: Text(
                                'Mật khẩu',
                                style: TextStyle(
                                  fontSize: DeviceHelper.getFontSize(14),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFE1E5ED)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFE1E5ED)),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              hintStyle: TextStyle(
                                color: const Color(0xFF777E90),
                                fontSize: DeviceHelper.getFontSize(14),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: 'Nhập mật khẩu',
                              contentPadding:
                                  const EdgeInsets.only(left: 16, right: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mật khẩu không được để trống!';
                              }
                              return null;
                            },
                          ).marginSymmetric(horizontal: 20, vertical: 6),
                          SizedBox(
                            width: double.infinity,
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 70),
                                ),
                                onPressed: controller.isWaitSubmit.value
                                    ? null
                                    : () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          controller.submit();
                                        }
                                      },
                                child: Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                    fontSize: DeviceHelper.getFontSize(16),
                                    color: AppColor.main,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ).marginSymmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
