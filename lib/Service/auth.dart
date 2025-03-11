import 'package:edocflow/Global/constant.dart';
import 'package:edocflow/Global/global_value.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Service/api_caller.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:get/get.dart';

class Auth {
  static backLogin(bool isRun) async {
    if (!isRun) {
      return null;
    }

    await Utils.saveStringWithKey(Constant.ACCESS_TOKEN, '');
    await Utils.saveStringWithKey(Constant.USERNAME, '');
    await Utils.saveStringWithKey(Constant.PASSWORD, '');
    if (Get.currentRoute != Routes.login) {
      Get.offAllNamed(Routes.login);
    }
  }

  static login({String? userName, String? password}) async {
    String userNamePreferences =
        await Utils.getStringValueWithKey(Constant.USERNAME);
    String passwordPreferences =
        await Utils.getStringValueWithKey(Constant.PASSWORD);

    var param = {
      "username": userName ?? userNamePreferences,
      "password": Utils.generateMd5(password ?? passwordPreferences),
      "ip": "",
      "address": ""
      // "fcmToken": await Utils.getStringValueWithKey(Constant.FCMTOKEN)
    };
    if (userName?.trim() == '' && userNamePreferences == '') {
      Utils.showSnackBar(
          title: 'Thông báo', message: 'Vui lòng nhập tên đăng nhâp!');
      return;
    }
    if (password?.trim() == '' && passwordPreferences == '') {
      Utils.showSnackBar(
          title: 'Thông báo', message: 'Vui lòng nhập mật khẩu!');
      return;
    }
    try {
      var data = await APICaller.getInstance().post('v1/Account/login', param);

      if (data != null) {
        GlobalValue.getInstance().setToken('Bearer ${data['data']['token']}');
        Utils.saveStringWithKey(Constant.ACCESS_TOKEN, data['data']['token']);
        Utils.saveStringWithKey(
            Constant.UUID_USER_ACC, data['data']['uuid'] ?? '');
        Utils.saveStringWithKey(
            Constant.USERNAME, data['data']['username'] ?? '');
        Utils.saveStringWithKey(
            Constant.FULL_NAME, data['data']['name'] ?? '');
        Utils.saveStringWithKey(
            Constant.PASSWORD, password ?? passwordPreferences);
        Get.offAllNamed(Routes.dashboard);
      } else {
        backLogin(true);
      }
    } catch (e) {
      Utils.showSnackBar(title: 'Thông báo', message: '$e');
    }
  }
}
