import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Service/auth.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController usermame = TextEditingController();
  TextEditingController password = TextEditingController();
  String? token = '';

  @override
  onInit() async {
    super.onInit();
    await firebaseMessaging();
  }

  firebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    token = await messaging.getToken();
    await Utils.saveStringWithKey(Constant.FCMTOKEN, token ?? "");
  }

  // Submit
  Future submit() async {
    isWaitSubmit.value = true;
    try {
      var response = await APICaller.getInstance().get('');

      if (response != null) {
        await Auth.login(
          userName: usermame.text.trim(),
          password: password.text.trim(),
        );
      }
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    } finally {
      isWaitSubmit.value = false;
    }
  }
}
