import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Model/dashboard.dart';
import 'package:edocflow/Model/issuingauthority.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxString name = ''.obs;
  RxString avatar = ''.obs;
  final String baseUrl = dotenv.env['API_URL'] ?? '';
  Rx<Dashboard> detail = Dashboard().obs;
  // Time filter
  List<Filter> listTimeFilter = [
    Filter(title: "Tất cả", value: "all"),
    Filter(title: "Tháng này", value: "this_month"),
    Filter(title: "Tháng trước", value: "last_month"),
    Filter(title: "Năm nay", value: "this_year"),
    Filter(title: "Năm trước", value: "last_year"),
  ];
  RxString timeFilter = 'Tất cả'.obs;
  String timeFilterValue = 'all';
  // Issuing Authority
  bool isIAFirstFetch = true;
  String selectedIAUUID = "";
  RxList<IssuingAuthority> iaCollection = <IssuingAuthority>[].obs;
  RxBool isLoadingIA = false.obs;
  TextEditingController iaName = TextEditingController();
  TextEditingController searchIA = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Utils.getStringValueWithKey(Constant.NAME).then((value) {
      name.value = value;
    });
    Utils.getStringValueWithKey(Constant.AVATAR).then((value) {
      avatar.value = baseUrl + value;
    });
    getData();
  }

  updateName(String name) {
    this.name.value = name;
  }

  updateAvatar(String avatar) {
    this.avatar.value = baseUrl + avatar;
  }

  refreshData() async {
    await getData();
  }

  Future getData({bool isRefresh = true}) async {
    if(isRefresh) isLoading.value = true;
    try {
      var response = await APICaller.getInstance()
          .get('v1/dashboard?filterType=$timeFilterValue&issuingAuthority=$selectedIAUUID');
      if (response['data'] != null && response['message'] == null) {
        detail.value = Dashboard.fromJson(response['data']);
      } else {
        Utils.showSnackBar(title: 'Thông báo', message: response['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {
      if(isRefresh) isLoading.value = false;
    }
  }

  onTapTimeFilter(Filter filter) {
    if (filter.value == timeFilterValue) return;
    Get.back();
    timeFilter.value = filter.title;
    timeFilterValue = filter.value;
    getData(isRefresh: false);
  }
}

class Filter {
  String title;
  String value;

  Filter({required this.title, required this.value});
}
