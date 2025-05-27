import 'dart:io';

import 'package:edocflow/Controller/User/user_controller.dart';
import 'package:edocflow/Model/profile.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/time_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();
  Rx<File> avatarLocal = File('').obs;
  RxInt gender = 1.obs;
  TextEditingController birthDay = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  // Permission
  bool isPFirstFetch = true;
  int selectedPUUID = -1;
  RxList<Permission> pCollection = <Permission>[].obs;
  RxBool isLoadingP = false.obs;
  TextEditingController pName = TextEditingController();
  TextEditingController searchP = TextEditingController();
  // Issuing Authority
  bool isIAFirstFetch = true;
  String selectedIAUUID = "";
  RxList<IssuingAuthority> iaCollection = <IssuingAuthority>[].obs;
  RxBool isLoadingIA = false.obs;
  TextEditingController iaName = TextEditingController();
  TextEditingController searchIA = TextEditingController();

  // Permission
  void initP() {
    if (isPFirstFetch) getPCollection(isRefresh: true);
    isPFirstFetch = false;
  }

  void getPCollection({bool isRefresh = false, bool isClearData = true}) {
    if (isRefresh) isLoadingP.value = true;
    if (isClearData) pCollection.clear();
    try {
      APICaller.getInstance()
          .get('v1/permission/dropdown?keyword=${searchP.text.trim()}')
          .then((response) {
        isLoadingP.value = false;
        if (response != null) {
          List<dynamic> list = response['data'];
          var listItem =
              list.map((dynamic json) => Permission.fromJson(json)).toList();
          pCollection.addAll(listItem);
        }
      });
    } catch (e) {
      isLoadingP.value = false;
      debugPrint(e.toString());
    }
  }

  // Issuing Authority
  void initIA() {
    if (isIAFirstFetch) getIACollection(isRefresh: true);
    isIAFirstFetch = false;
  }

  void getIACollection({bool isRefresh = false, bool isClearData = true}) {
    if (isRefresh) isLoadingIA.value = true;
    if (isClearData) iaCollection.clear();
    try {
      APICaller.getInstance()
          .get('v1/issuingauthority/dropdown?keyword=${searchIA.text.trim()}')
          .then((response) {
        isLoadingIA.value = false;
        if (response != null) {
          List<dynamic> list = response['data'];
          var listItem = list
              .map((dynamic json) => IssuingAuthority.fromJson(json))
              .toList();
          iaCollection.addAll(listItem);
        }
      });
    } catch (e) {
      isLoadingIA.value = false;
      debugPrint(e.toString());
    }
  }

  submit() {
    isWaitSubmit.value = true;
    try {
      isWaitSubmit.value = false;
      if (avatarLocal.value.path.isEmpty) {
        APICaller.getInstance().post('v1/user/create', body: {
          'name': name.text.trim(),
          'gender': gender.value == -1 ? null : gender.value,
          'birth_day': TimeHelper.convertDateFormat(birthDay.text, true),
          'phone': phone.text.trim(),
          'email': email.text.trim() == '' ? null : email.text.trim(),
          'permission': selectedPUUID == -1 ? null : selectedPUUID,
          'issuing_authority': selectedIAUUID == '' ? null : selectedIAUUID,
          'avatar': null,
        }).then((response) {
          if (Get.isRegistered<UserController>()) {
            Get.find<UserController>().refreshData();
          }
          Get.back();
          Utils.showSnackBar(title: "Thông báo", message: response['message']);
          return;
        });
        return;
      }
      APICaller.getInstance().postFile(file: avatarLocal.value).then((value) {
        APICaller.getInstance().post('v1/user/create', body: {
          'name': name.text.trim(),
          'gender': gender.value == -1 ? null : gender.value,
          'birth_day': TimeHelper.convertDateFormat(birthDay.text, true),
          'phone': phone.text.trim(),
          'email': email.text.trim() == '' ? null : email.text.trim(),
          'permission': selectedPUUID == -1 ? null : selectedPUUID,
          'issuing_authority': selectedIAUUID == '' ? null : selectedIAUUID,
          'avatar': value['file']
        }).then((response) {
          if (response == null) {
            APICaller.getInstance().delete('v1/file/${value['file']}');
          } else {
            if (Get.isRegistered<UserController>()) {
            Get.find<UserController>().refreshData();
          }
            Get.back();
            Utils.showSnackBar(
                title: "Thông báo", message: response['message']);
          }
        });
      });
    } catch (e) {
      isWaitSubmit.value = false;
      debugPrint(e.toString());
    }
  }
}
