import 'dart:async';

import 'package:edocflow/Model/field.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FieldController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = true.obs;
  RxBool isWaitSubmit = true.obs;
  int page = 1;
  int limit = 12;
  RxInt totalCount = 0.obs;
  int totalPage = 0;
  Timer? debounceTimer;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Field> collection = RxList<Field>();

  @override
  void onInit() async {
    super.onInit();
    await getData(isRefresh: true);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (totalPage > page) {
          page++;
          getData(isClearData: false);
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    searchController.value.dispose();
  }

  Future getData({bool isRefresh = false, bool isClearData = true}) async {
    if (isRefresh) isLoading.value = true;
    if (isClearData) collection.clear();
    try {
      var response = await APICaller.getInstance().get(
          'v1/field?page=$page&limit=$limit&keyword=${searchController.value.text.trim()}');
      if (response['data'] != null && response['message'] == null) {
        totalCount.value = response['pagination']['totalCount'];
        totalPage = response['pagination']['totalPage'];
        List<dynamic> list = response['data'];
        var listItem =
            list.map((dynamic json) => Field.fromJson(json)).toList();
        collection.addAll(listItem);
      } else {
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      }
    } catch (e) {
      Utils.showSnackBar(title: 'Error!', message: 'Đã có lỗi xảy ra: $e!');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  refreshData() async {
    page = 1;
    searchController.value.clear();
    await getData(isRefresh: true);
  }
}
