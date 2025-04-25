import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  RxBool isHidePass = true.obs;
  RxBool isHideNew = true.obs;
  RxBool isHideConfirm = true.obs;

  submit() async {
    isWaitSubmit.value = true;
    try {
      var param = {
        "current_password": Utils.generateMd5(oldPassword.text.trim()),
        "password": Utils.generateMd5(newPassword.text.trim())
      };
      APICaller.getInstance()
          .put('v1/user/change-password', body: param)
          .then((response) {
        isWaitSubmit.value = false;
        if (response != null) {
          Get.back();
          Utils.showSnackBar(
              title: 'Thông báo!', message: 'Đã đổi mật khẩu thành công!');
        }
      });
    } catch (e) {
      Utils.showSnackBar(title: 'Error!', message: 'Đã có lỗi xảy ra: $e!');
      isWaitSubmit.value = false;
    }
  }
}