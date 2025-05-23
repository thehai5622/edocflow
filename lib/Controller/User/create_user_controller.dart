import 'dart:io';

import 'package:edocflow/Model/profile.dart';
import 'package:edocflow/Service/api_caller.dart';
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
          var listItem = list
              .map((dynamic json) => Permission.fromJson(json))
              .toList();
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
    } catch (e) {
      debugPrint(e.toString());
      isWaitSubmit.value = false;
    }
  }
}
