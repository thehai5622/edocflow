import 'package:edocflow/Controller/IssuingAuthority/issuingauthority_controller.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateIssuingAuthorityController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();

  void back() {
    Get.back();
  }

  void submit() {
    isWaitSubmit.value = true;
    try {
      final param = {
        "name": name.text.trim(),
      };

      APICaller.getInstance().post('v1/issuingauthority', body: param).then((response) {
        if (Get.isRegistered<IssuingAuthorityController>()) {
          Get.find<IssuingAuthorityController>().refreshData();
        }
        Get.back();
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      });
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    } finally {
      isWaitSubmit.value = false;
    }
  }
}
