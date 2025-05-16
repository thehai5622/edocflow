import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomsheet {
  static final TextStyle _textStyle = TextStyle(
    fontSize: DeviceHelper.getFontSize(15),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: AppColor.text1,
  );

  static Future<T?> show<T>(
      {required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: AppColor.white,
      builder: (context) => Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 15),
            child,
          ],
        ),
      ),
    );
  }

  static GestureDetector item({
    required String title,
    void Function()? onTap,
    String icon = "assets/icons/document.svg",
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 1,
          color: AppColor.boder,
        ))),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: _textStyle)),
          ],
        ),
      ),
    );
  }
}
