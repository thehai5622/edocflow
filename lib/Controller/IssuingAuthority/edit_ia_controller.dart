import 'package:edocflow/Controller/IssuingAuthority/issuingauthority_controller.dart';
import 'package:edocflow/Model/Issuingauthority.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditIssuingAuthorityController extends GetxController {
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();
  late IssuingAuthority item;
  // Administrative Level
  bool isALFirstFetch = true;
  int selectedALUUID = -1;
  RxList<AdministrativeLevel> aLCollection = <AdministrativeLevel>[].obs;
  RxBool isLoadingAL = false.obs;
  TextEditingController aLName = TextEditingController();
  TextEditingController searchAL = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments;
    name.text = item.name ?? '';
  }

  void back() {
    Get.back();
  }

  // Administrative Level
  void initAL() {
    if (isALFirstFetch) getALCollection(isRefresh: true);
    isALFirstFetch = false;
  }

  void getALCollection({bool isRefresh = false, bool isClearData = true}) {
    if (isRefresh) isLoadingAL.value = true;
    if (isClearData) aLCollection.clear();
    try {
      APICaller.getInstance()
          .get('v1/administrativelevel?keyword=${searchAL.text.trim()}')
          .then((response) {
        isLoadingAL.value = false;
        if (response != null) {
          List<dynamic> list = response['data'];
          var listItem = list
              .map((dynamic json) => AdministrativeLevel.fromJson(json))
              .toList();
          aLCollection.addAll(listItem);
        }
      });
    } catch (e) {
      isLoadingAL.value = false;
      debugPrint(e.toString());
    }
  }

  submit() {
    isWaitSubmit.value = true;
    try {
      final param = {
        "name": name.text.trim(),
      };
      APICaller.getInstance()
          .put('v1/issuingauthority/${item.uuid}', body: param)
          .then((response) {
        if (Get.isRegistered<IssuingAuthorityController>()) {
          Get.find<IssuingAuthorityController>().refreshData();
        }
        Get.back();
        isWaitSubmit.value = false;
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      });
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    } finally {
      isWaitSubmit.value = false;
    }
  }
}
