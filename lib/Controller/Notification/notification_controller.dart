import 'dart:convert';

import 'package:edocflow/Controller/dashboard_controller.dart';
import 'package:edocflow/Model/notification.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = true.obs;
  RxBool isShowClearText = false.obs;
  int page = 1;
  int limit = 12;
  RxInt totalCount = 0.obs;
  int totalPage = 0;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<NotificationApp> collection = RxList<NotificationApp>();

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

  refreshData() async {
    page = 1;
    searchController.value.clear();
    await getData(isRefresh: true);
  }

  Future getData({bool isRefresh = false, bool isClearData = true}) async {
    if (isRefresh) isLoading.value = true;
    if (isClearData) collection.clear();
    try {
      var response = await APICaller.getInstance()
          .get('v1/notification?page=$page&limit=$limit');
      if (response['data'] != null && response['message'] == null) {
        totalCount.value = response['pagination']['totalCount'];
        totalPage = response['pagination']['totalPage'];
        List<dynamic> list = response['data'];
        var listItem =
            list.map((dynamic json) => NotificationApp.fromJson(json)).toList();
        collection.addAll(listItem);
      } else {
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  tapItem(int index) {
    try {
      APICaller.getInstance().post(
          'v1/notification/read/${collection[index].uuid}',
          body: {}).then(
        (response) {
          collection[index].isRead = 1;
          collection.refresh();
        },
      );
      var data = jsonDecode(collection[index].data ?? "");
      if (data['uuid'] != "" && data['type'] == "document") {
        Get.toNamed(Routes.detailDocument, arguments: {
          'uuid': data['uuid'],
          'document': data['more'],
        });
      } else if (data['uuid'] == "" && data['type'] == "document") {
        Get.back();
        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().changePage(1);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
