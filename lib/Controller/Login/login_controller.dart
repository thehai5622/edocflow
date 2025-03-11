import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController usermame = TextEditingController();
  TextEditingController password = TextEditingController();

  // Submit
  Future submit() async {
    isWaitSubmit.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    } finally {
      isWaitSubmit.value = false;
    }
  }
}
