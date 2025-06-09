import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Model/dashboard.dart';
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
  Dashboard detail = Dashboard();

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

  Future getData() async {
    isLoading.value = true;
    try {
      var response = await APICaller.getInstance().get('v1/dashboard');
      if (response['data'] != null && response['message'] == null) {
        detail = Dashboard.fromJson(response['data']);
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
}
