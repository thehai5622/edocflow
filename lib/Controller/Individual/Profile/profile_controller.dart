import 'dart:io';

import 'package:edocflow/Controller/Individual/individual_controller.dart';
import 'package:edocflow/Global/constant.dart';
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
  RxInt gender = (-1).obs;
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
    gender.value = detail.gender ?? -1;
    birthDay.text = TimeHelper.convertDateFormat(detail.birthDay, false);
    phone.text = detail.phone ?? '';
    email.text = detail.email ?? '';
    avatar.value = detail.avatar ?? '';
  }

  submit() {
    isWaitSubmit.value = true;
    try {
      isWaitSubmit.value = false;
      if (avatarLocal.value.path.isEmpty) {
        APICaller.getInstance().put('v1/user/me', body: {
          'name': name.text.trim(),
          'gender': gender.value == -1 ? null : gender.value,
          'birthDay': TimeHelper.convertDateFormat(birthDay.text, true),
          'phone': phone.text.trim(),
          'email': email.text.trim(),
          'avatar': detail.avatar,
        }).then((response) {
          if (Get.isRegistered<IndividualController>()) {
            Get.find<IndividualController>().updateName(name.text.trim());
          }
          Utils.saveStringWithKey(Constant.NAME, name.text.trim());
          Get.back();
          Utils.showSnackBar(title: "Thông báo", message: response['message']);
          return;
        });
      }
      APICaller.getInstance().postFile(file: avatarLocal.value).then((value) {
        APICaller.getInstance().put('v1/user/me', body: {
          'name': name.text.trim(),
          'gender': gender.value == -1 ? null : gender.value,
          'birthDay': TimeHelper.convertDateFormat(birthDay.text, true),
          'phone': phone.text.trim(),
          'email': email.text.trim(),
          'avatar': value['file']
        }).then((response) {
          if (response == null) {
            APICaller.getInstance().delete('v1/file/${value['file']}');
          } else {
            if (Get.isRegistered<IndividualController>()) {
              Get.find<IndividualController>().updateAvatar(value['file']);
              Get.find<IndividualController>().updateName(name.text.trim());
            }
            Utils.saveStringWithKey(Constant.NAME, name.text.trim());
            Utils.saveStringWithKey(Constant.AVATAR, value['file']);
            Get.back();
            Utils.showSnackBar(
                title: "Thông báo", message: response['message']);
          }
        });
      });
    } catch (e) {
      isWaitSubmit.value = false;
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    }
  }
}
