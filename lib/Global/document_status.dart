import 'dart:ui';

import 'package:edocflow/Global/app_color.dart';

class DocumentStatus {
  static String getTextStatus(int status) {
    switch (status) {
      case 1:
        return "Chưa xử lý";
      case 2:
        return "Chờ duyệt";
      case 3:
        return "Chờ phát hành";
      case 4:
        return "Hoạt động";
      case 5:
        return "Quá hạn";
      default:
        return "Hủy bỏ";
    }
  }

  static Color getColorStatus(int status) {
    switch (status) {
      case 1:
        return AppColor.dstatus1;
      case 2:
        return AppColor.dstatus2;
      case 3:
        return AppColor.dstatus3;
      case 4:
        return AppColor.dstatus4;
      case 5:
        return AppColor.dstatus5;
      default:
        return AppColor.red;
    }
  }
}