import 'package:edocflow/Global/app_color.dart';
import 'package:flutter/material.dart';

class CustomBottomsheet {
  static Future<T?> show<T>(
      {required BuildContext context,
      required Widget child}) {
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
}
