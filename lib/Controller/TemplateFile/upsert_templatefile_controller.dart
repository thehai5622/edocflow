import 'dart:io';

import 'package:edocflow/Controller/TemplateFile/templatefile_controller.dart';
import 'package:edocflow/Model/templatefile.dart';
import 'package:edocflow/Model/type_template_file.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpsertTFController extends GetxController {
  late String uuid;
  late String title;
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();
  TemplateFile detail = TemplateFile();
  Rx<File> file = Rx<File>(File(""));
  RxString fileSize = "".obs;
  RxInt type = 1.obs;
  RxInt status = 1.obs;
  TextEditingController note = TextEditingController();
  bool isChangeFile = false;
  // Type Template File
  bool isTTFFirstFetch = true;
  String selectedTTFUUID = "";
  RxList<TypeTemplateFile> ttfCollection = <TypeTemplateFile>[].obs;
  RxBool isLoadingTTF = false.obs;
  TextEditingController ttfName = TextEditingController();
  TextEditingController searchTTF = TextEditingController();

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    if (uuid == "") {
      title = "Thêm file mẫu";
    } else {
      title = "Chỉnh sửa file mẫu";
      getDetail();
    }
    super.onInit();
  }

  getDetail() {
    isWaitSubmit.value = true;
    try {
      APICaller.getInstance().get("v1/template-file/$uuid").then((value) {
        isWaitSubmit.value = false;
        if (value != null) {
          detail = TemplateFile.fromJson(value['data']);
          _setValue();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      isWaitSubmit.value = false;
    }
  }

  _setValue() {
    name.text = detail.name ?? '';
    selectedTTFUUID = detail.typeTemplateFile?.uuid ?? '';
    ttfName.text = detail.typeTemplateFile?.name ?? '';
    type.value = detail.type ?? 1;
    status.value = detail.status ?? 1;
    note.text = detail.note ?? '';
    APICaller.getInstance().downloadAndGetFile(detail.file ?? "").then((value) {
      if (value != null) {
        file.value = value;
        file.value.length().then((data) {
          fileSize.value = "$data bytes";
        });
      }
    });
  }

  // Type Template File
  void initTTF() {
    if (isTTFFirstFetch) getTTFCollection(isRefresh: true);
    isTTFFirstFetch = false;
  }

  void getTTFCollection({bool isRefresh = false, bool isClearData = true}) {
    if (isRefresh) isLoadingTTF.value = true;
    if (isClearData) ttfCollection.clear();
    try {
      APICaller.getInstance()
          .get('v1/typetemplatefile/dropdown?keyword=${searchTTF.text.trim()}')
          .then((response) {
        isLoadingTTF.value = false;
        if (response != null) {
          List<dynamic> list = response['data'];
          var listItem = list
              .map((dynamic json) => TypeTemplateFile.fromJson(json))
              .toList();
          ttfCollection.addAll(listItem);
        }
      });
    } catch (e) {
      isLoadingTTF.value = false;
      debugPrint(e.toString());
    }
  }

  submit() {
    isWaitSubmit.value = true;
    try {
      if (uuid == "") {
        APICaller.getInstance().postFile(file: file.value).then((res) {
          var param = {
            "name": name.text,
            "typetemplatefile_id": selectedTTFUUID,
            "file": res['file'],
            "type": type.value,
            "status": status.value,
            "note": note.text == "" ? null : note.text,
          };
          APICaller.getInstance()
              .post('v1/template-file', body: param)
              .then((value) {
            isWaitSubmit.value = false;
            if (value != null) {
              if (Get.isRegistered<TemplateFileController>()) {
                Get.find<TemplateFileController>().refreshData();
              }
              Get.back();
              Utils.showSnackBar(
                title: 'Thông báo!',
                message: value['message'],
              );
            }
          });
        });
      } else {
        if (isChangeFile == true) {
          APICaller.getInstance().postFile(file: file.value).then((res) {
            var param = {
              "name": name.text,
              "typetemplatefile_id": selectedTTFUUID,
              "file": res['file'],
              "type": type.value,
              "status": status.value,
              "note": note.text == "" ? null : note.text,
            };
            APICaller.getInstance()
                .put('v1/template-file/$uuid', body: param)
                .then((value) {
              isWaitSubmit.value = false;
              if (value != null) {
                if (Get.isRegistered<TemplateFileController>()) {
                  Get.find<TemplateFileController>().refreshData();
                }
                Get.back();
                Utils.showSnackBar(
                  title: 'Thông báo!',
                  message: value['message'],
                );
              }
            });
          });
        } else {
          var param = {
            "name": name.text,
            "typetemplatefile_id": selectedTTFUUID,
            "file": detail.file,
            "type": type.value,
            "status": status.value,
            "note": note.text == "" ? null : note.text,
          };
          APICaller.getInstance()
              .put('v1/template-file/$uuid', body: param)
              .then((value) {
            isWaitSubmit.value = false;
            if (value != null) {
              if (Get.isRegistered<TemplateFileController>()) {
                Get.find<TemplateFileController>().refreshData();
              }
              Get.back();
              Utils.showSnackBar(
                title: 'Thông báo!',
                message: value['message'],
              );
            }
          });
        }
      }
      isWaitSubmit.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isWaitSubmit.value = false;
    }
  }
}
