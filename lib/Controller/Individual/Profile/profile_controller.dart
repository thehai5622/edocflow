import 'dart:io';

import 'package:edocflow/Model/profile.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/time_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isWaitSubmit = true.obs;
  RxBool isEdit = false.obs;
  RxString avatar = ''.obs;
  Rx<File> avatarLocal = File('').obs;
  final String baseUrl = dotenv.env['API_URL'] ?? '';
  Profile detail = Profile();
  TextEditingController name = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  TextEditingController birthDay = TextEditingController();
  TextEditingController phone = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  TextEditingController email = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDetail();
  }

  cancel() {
    isEdit.value = false;
    avatarLocal.value = File('');
  }

  getDetail() {
    isWaitSubmit.value = true;
    try {
      APICaller.getInstance().get("v1/user/me").then((value) {
        isWaitSubmit.value = false;
        if (value != null) {
          detail = Profile.fromJson(value['data']);
          _setValue();
        }
      });
    } catch (e) {
      isWaitSubmit.value = false;
      Utils.showSnackBar(title: 'Error!', message: 'Đã có lỗi xảy ra:\n$e!');
    }
  }

  _setValue() {
    name.text = detail.name ?? '';
    birthDay.text = TimeHelper.convertDateFormat(detail.birthDay, false);
    phone.text = detail.phone ?? '';
    email.text = detail.email ?? '';
  }

  submit() {
    isWaitSubmit.value = true;
    try {
      isWaitSubmit.value = false;
    } catch (e) {
      isWaitSubmit.value = false;
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    }
  }
}
