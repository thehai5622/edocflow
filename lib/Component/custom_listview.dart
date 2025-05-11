import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';

class CustomListView {
  static final TextStyle _textStyle = TextStyle(
    fontSize: DeviceHelper.getFontSize(15),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: AppColor.primary,
  );

  static Widget show({
    required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
    double gap = 12,
    ScrollController? controller,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
  }) {
    return ListView.separated(
      physics: physics,
      padding: padding,
      scrollDirection: scrollDirection,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      controller: controller,
      separatorBuilder: (context, index) => SizedBox(height: gap),
      itemBuilder: itemBuilder,
    );
  }

  static Widget viewItem({
    void Function()? onTap,
    String? title,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          width: 1,
          color: AppColor.boder,
        ))),
        child: Row(
          children: [
            Expanded(child: Text(title ?? "--", style: _textStyle)),
            const SizedBox(width: 20),
            if (isSelected) Icon(Icons.check, color: AppColor.primary)
          ],
        ),
      ),
    );
  }
}
