import 'package:edocflow/Model/templatefile.dart';
import 'package:edocflow/Model/type_template_file.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpsertTFController extends GetxController {
  late String uuid;
  late String title;
  RxBool isWaitSubmit = false.obs;
  TextEditingController name = TextEditingController();
  TemplateFile detail = TemplateFile();
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
      // if (image.value.path == "") {
      //   var param = {
      //     "uuid": detail.value.uuid ?? "",
      //     "name": detail.value.name ?? "",
      //     "email": email.text,
      //     "address": address.text,
      //     "gender": gender.value,
      //     "birthday": convertDateFormat(birthday.text, true),
      //     "height": int.parse(height.text),
      //     "weight": int.parse(weight.text),
      //     "phoneNumber": phoneNumber.text,
      //     "introduce": introduce.text,
      //     "skill": skill.text,
      //     "hobby": hobby.text,
      //     "imagePath": detail.value.imagePath ?? "",
      //   };
      //   APICaller.getInstance().post('v1/Cv/upsert-cv', param).then((value) {
      //     isWaitSubmit.value = false;
      //     if (value != null) {
      //       if (Get.isRegistered<CVManagementController>()) {
      //         Get.find<CVManagementController>().getDetail();
      //       }
      //       Get.back();
      //       Utils.showSnackBar(
      //         title: 'Thông báo!',
      //         message:
      //             'Đã ${isCreate ? "khởi tạo" : "chỉnh sửa"} CV thành công!',
      //       );
      //     }
      //   });
      // } else {
      //   APICaller.getInstance()
      //       .putFile(
      //         endpoint: 'v1/Upload/upload-single-image',
      //         filePath: image.value,
      //         type: 9,
      //       )
      //       .then((response) {
      //         if (response != null) {
      //           var param = {
      //             "uuid": detail.value.uuid ?? "",
      //             "name": detail.value.name ?? "",
      //             "email": email.text,
      //             "address": address.text,
      //             "gender": gender.value,
      //             "birthday": convertDateFormat(birthday.text, true),
      //             "height": int.parse(height.text),
      //             "weight": int.parse(weight.text),
      //             "phoneNumber": phoneNumber.text,
      //             "introduce": introduce.text,
      //             "skill": skill.text,
      //             "hobby": hobby.text,
      //             "imagePath": response["data"],
      //           };
      //           APICaller.getInstance().post('v1/Cv/upsert-cv', param).then((
      //             value,
      //           ) {
      //             isWaitSubmit.value = false;
      //             if (value != null) {
      //               if (Get.isRegistered<CVManagementController>()) {
      //                 Get.find<CVManagementController>().getDetail();
      //               }
      //               Get.back();
      //               Utils.showSnackBar(
      //                 title: 'Thông báo!',
      //                 message:
      //                     'Đã ${isCreate ? "khởi tạo" : "chỉnh sửa"} CV thành công!',
      //               );
      //             }
      //           });
      //         }
      //       });
      // }
      isWaitSubmit.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isWaitSubmit.value = false;
    }
  }
}
