import 'package:edocflow/Service/api_caller.dart';
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
      // await Auth.login(userName: usermame.text, password: password.text);
      var response = await APICaller.getInstance().get('');

      if (response != null) {
        print(response);
      }
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    } finally {
      isWaitSubmit.value = false;
    }
  }
}
