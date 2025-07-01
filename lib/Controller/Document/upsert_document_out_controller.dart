import 'package:edocflow/Controller/Document/document_out_controller.dart';
import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Model/Issuingauthority.dart';
import 'package:edocflow/Model/document.dart';
import 'package:edocflow/Model/field.dart';
import 'package:edocflow/Model/templatefile.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/time_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpsertDocumentOutController extends GetxController {
  late String uuid;
  late String title;
  RxBool isWaitSubmit = false.obs;
  Document detail = Document();
  TextEditingController referenceNumber = TextEditingController();
  TextEditingController summary = TextEditingController();
  TextEditingController originalLocation = TextEditingController();
  TextEditingController numberReleases = TextEditingController();
  RxString urgencyLevel = "0".obs;
  RxString confidentialityLevel = "0".obs;
  TextEditingController release = TextEditingController();
  // Issuing Authority
  bool isIAFirstFetch = true;
  String selectedIAUUID = "";
  RxList<IssuingAuthority> iaCollection = <IssuingAuthority>[].obs;
  RxBool isLoadingIA = false.obs;
  TextEditingController iaName = TextEditingController();
  TextEditingController searchIA = TextEditingController();
  // Type Template File
  bool isTFFirstFetch = true;
  String selectedTFUUID = "";
  RxList<TemplateFile> tfCollection = <TemplateFile>[].obs;
  RxBool isLoadingTF = false.obs;
  TextEditingController tfName = TextEditingController();
  TextEditingController searchTF = TextEditingController();
  // Field
  bool isFFirstFetch = true;
  String selectedFUUID = "";
  RxList<Field> fCollection = <Field>[].obs;
  RxBool isLoadingF = false.obs;
  TextEditingController fName = TextEditingController();
  TextEditingController searchF = TextEditingController();

  @override
  void onInit() {
    uuid = Get.arguments?["uuid"] ?? "";
    if (uuid == "") {
      title = "Thêm văn bản đi";
    } else {
      title = "Chỉnh sửa văn bản đi";
      getDetail();
    }
    super.onInit();
  }

  getDetail() {
    isWaitSubmit.value = true;
    try {
      APICaller.getInstance().get("v1/document/$uuid").then((value) {
        isWaitSubmit.value = false;
        if (value != null) {
          detail = Document.fromJson(value['data']);
          _setValue();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      isWaitSubmit.value = false;
    }
  }

  _setValue() {
    selectedIAUUID = detail.issuingauthority?.uuid ?? "";
    iaName.text = detail.issuingauthority?.name ?? "";
    selectedTFUUID = detail.templatefile?.uuid ?? "";
    tfName.text = detail.templatefile?.name ?? "";
    selectedFUUID = detail.field?.uuid ?? "";
    fName.text = detail.field?.name ?? "";
    summary.text = detail.summary ?? "";
    referenceNumber.text = detail.referenceNumber ?? "";
    release.text = TimeHelper.convertDateFormat(detail.release, false);
    originalLocation.text = detail.originalLocation ?? "";
    numberReleases.text = "${detail.numberReleases}";
    urgencyLevel.value = "${detail.urgencyLevel}";
    confidentialityLevel.value = "${detail.confidentialityLevel}";
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

  // Type Template File
  void initTF() {
    if (isTFFirstFetch) getTFCollection(isRefresh: true);
    isTFFirstFetch = false;
  }

  void getTFCollection({bool isRefresh = false, bool isClearData = true}) {
    if (isRefresh) isLoadingTF.value = true;
    if (isClearData) tfCollection.clear();
    try {
      APICaller.getInstance()
          .get('v1/template-file/dropdown?keyword=${searchTF.text.trim()}')
          .then((response) {
        isLoadingTF.value = false;
        if (response != null) {
          List<dynamic> list = response['data'];
          var listItem =
              list.map((dynamic json) => TemplateFile.fromJson(json)).toList();
          tfCollection.addAll(listItem);
        }
      });
    } catch (e) {
      isLoadingTF.value = false;
      debugPrint(e.toString());
    }
  }

  // Field
  void initF() {
    if (isFFirstFetch) getFCollection(isRefresh: true);
    isFFirstFetch = false;
  }

  void getFCollection({bool isRefresh = false, bool isClearData = true}) {
    if (isRefresh) isLoadingF.value = true;
    if (isClearData) fCollection.clear();
    try {
      APICaller.getInstance()
          .get('v1/field/dropdown?keyword=${searchF.text.trim()}')
          .then((response) {
        isLoadingF.value = false;
        if (response != null) {
          List<dynamic> list = response['data'];
          var listItem =
              list.map((dynamic json) => Field.fromJson(json)).toList();
          fCollection.addAll(listItem);
        }
      });
    } catch (e) {
      isLoadingF.value = false;
      debugPrint(e.toString());
    }
  }

  submit() async {
    isWaitSubmit.value = true;
    try {
      if (uuid == "") {
        var param = {
          "from_issuingauthority_id":
              await Utils.getStringValueWithKey(Constant.ISSUING_AUTHORITY),
          "issuing_authority": selectedIAUUID,
          "field": selectedFUUID,
          "template_file": selectedTFUUID,
          "summary": summary.text.trim(),
          "reference_number": referenceNumber.text.trim(),
          "release": TimeHelper.convertDateFormat(release.text, true),
          "original_location": originalLocation.text.trim(),
          "number_releases": int.tryParse(numberReleases.text.trim()),
          "urgency_level": int.tryParse(urgencyLevel.value.trim()),
          "confidentiality_level":
              int.tryParse(confidentialityLevel.value.trim()),
        };
        APICaller.getInstance().post('v1/document', body: param).then((value) {
          isWaitSubmit.value = false;
          if (value != null) {
            if (Get.isRegistered<DocumentOutController>()) {
              Get.find<DocumentOutController>().refreshData();
            }
            Get.back();
            Utils.showSnackBar(
              title: 'Thông báo!',
              message: value['message'],
            );
          }
        });
      } else {
        var param = {
          "field": selectedFUUID,
          "template_file": selectedTFUUID,
          "summary": summary.text.trim(),
          "reference_number": referenceNumber.text.trim(),
          "release": TimeHelper.convertDateFormat(release.text, true),
          "original_location": originalLocation.text.trim(),
          "number_releases": int.tryParse(numberReleases.text.trim()),
          "urgency_level": int.tryParse(urgencyLevel.value.trim()),
          "confidentiality_level":
              int.tryParse(confidentialityLevel.value.trim()),
        };
        APICaller.getInstance().put('v1/document/$uuid', body: param).then((value) {
          isWaitSubmit.value = false;
          if (value != null) {
            if (Get.isRegistered<DocumentOutController>()) {
              Get.find<DocumentOutController>().refreshData();
            }
            Get.back();
            Utils.showSnackBar(
              title: 'Thông báo!',
              message: value['message'],
            );
          }
        });
      }
      isWaitSubmit.value = false;
    } catch (e) {
      debugPrint(e.toString());
      isWaitSubmit.value = false;
    }
  }
}
