import 'package:edocflow/Controller/Document/document_in_controller.dart';
import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Model/department.dart';
import 'package:edocflow/Model/document.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailDocumentController extends GetxController {
  late String uuid;
  bool isIn = false;
  RxBool isLoading = false.obs;
  Document detail = Document();

  // department
  RxBool isLoadingD = false.obs;
  List<Department> colectionD = [];
  TextEditingController departmentTC = TextEditingController();
  String selectedD = "";

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    isIn = Get.arguments?["document"] == "in";
    getDetail();
    getDepartment();
    super.onInit();
  }

  getDetail() {
    isLoading.value = true;
    try {
      APICaller.getInstance().get("v1/document/$uuid").then((value) {
        if (value != null) {
          detail = Document.fromJson(value['data']);
          isLoading.value = false;
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future getDepartment() async {
    isLoadingD.value = true;
    try {
      String? issuingAuthority =
          await Utils.getStringValueWithKey(Constant.ISSUING_AUTHORITY);
      await APICaller.getInstance()
          .get("v1/department/dropdown?issuing_authority=$issuingAuthority")
          .then((response) {
        if (response != null) {
          List<dynamic> list = response['data'];
          var listItem =
              list.map((dynamic json) => Department.fromJson(json)).toList();
          colectionD.addAll(listItem);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      isLoadingD.value = false;
    } finally {
      isLoadingD.value = false;
    }
  }

  submit() {
    switch (detail.status) {
      case 1:
        receptionDocument();
        break;
      case 2:
        signDocument();
        break;
    }
  }

  Future receptionDocument() async {
    isLoading.value = true;
    try {
      await APICaller.getInstance()
          .post("v1/document/reception-document/$uuid", body: {
            "department": selectedD
          }).then((value) {
        if (value != null) {
          if (Get.isRegistered<DocumentInController>()) {
            Get.find<DocumentInController>().refreshData();
          }
          getDetail();
          Utils.showSnackBar(
            title: 'Thông báo!',
            message: value['message'],
          );
        }
      });
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future signDocument() async {
    isLoading.value = true;
    try {
      await APICaller.getInstance()
          .post("v1/document/sign-document/$uuid", body: {}).then((value) {
        if (value != null) {
          if (Get.isRegistered<DocumentInController>()) {
            Get.find<DocumentInController>().refreshData();
          }
          getDetail();
          Utils.showSnackBar(
            title: 'Thông báo!',
            message: value['message'],
          );
        }
      });
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
