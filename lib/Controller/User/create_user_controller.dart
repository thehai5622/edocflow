import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();
  Rx<File> avatarLocal = File('').obs;
  RxInt gender = (-1).obs;

  submit() {
    isWaitSubmit.value = true;
    try {
      isWaitSubmit.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isWaitSubmit.value = false;
    }
  }
}
