import 'dart:async';

import 'package:edocflow/Model/user.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final String imageBaseUrl = dotenv.env['IMAGE_URL'] ?? '';
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = true.obs;
  RxBool isShowClearText = false.obs;
  int page = 1;
  int limit = 12;
  RxInt totalCount = 0.obs;
  int totalPage = 0;
  Timer? debounceTimer;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<User> collection = RxList<User>();
  TextEditingController username = TextEditingController();
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

  refreshData() async {
    page = 1;
    searchController.value.clear();
    await getData(isRefresh: true);
  }

  Future getData({bool isRefresh = false, bool isClearData = true}) async {
    if (isRefresh) isLoading.value = true;
    if (isClearData) collection.clear();
    try {
      var response = await APICaller.getInstance().get(
          'v1/user?page=$page&limit=$limit&keyword=${searchController.value.text.trim()}');
      if (response['data'] != null && response['message'] == null) {
        totalCount.value = response['pagination']['totalCount'];
        totalPage = response['pagination']['totalPage'];
        List<dynamic> list = response['data'];
        var listItem = list.map((dynamic json) => User.fromJson(json)).toList();
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

  deleteItem(int index) {
    APICaller.getInstance()
        .delete('v1/user/${collection[index].uuid}')
        .then((response) {
      Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      totalCount.value--;
      collection.removeAt(index);
    });
  }

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

  void updateItem(int index) {
    try {
      APICaller.getInstance().put('v1/user/update-user/${collection[index].uuid}', body: {
        'permission': selectedPUUID,
        'issuing_authority': selectedIAUUID,
      }).then((response) {
        refreshData();
        Get.back();
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void provideAccount(int index) {
    try {
      APICaller.getInstance().put('v1/user/provide-account/${collection[index].uuid}', body: {
        'username': username.text.trim(),
        'password': Utils.generateMd5("123456"),
      }).then((response) {
        refreshData();
        Get.back();
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
