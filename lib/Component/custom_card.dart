import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';

class CustomCard {
  static Text title({required String title, required String value}) {
    return Text(
      "-------   $title: $value   -------",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: DeviceHelper.getFontSize(17),
        color: AppColor.text1,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static GestureDetector collectionItem({
    required BuildContext context,
    void Function()? onTap,
    String? status,
    Color? stausColor,
    List<Widget> children = const <Widget>[],
    List<Widget> actions = const <Widget>[],
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.main,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 2,
                color: AppColor.background,
              ))),
              child: Column(
                children: children,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (status != null) Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                        color: stausColor ?? AppColor.primary,
                        borderRadius: BorderRadius.circular(9)),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: DeviceHelper.getFontSize(13),
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Row infoRow(
      {required String title,
      required String value,
      bool isHightlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(15),
            color: AppColor.text1,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: DeviceHelper.getFontSize(15),
              color: isHightlight ? AppColor.primary : AppColor.text1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  static GestureDetector actionItem(
      {void Function()? onTap,
      required Color bgColor,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
        child: Icon(icon, color: AppColor.white, size: 17),
      ),
    );
  }
}
