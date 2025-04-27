import 'package:edocflow/Global/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static ElevatedButton primary({
    required String text,
    void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          color: AppColor.white,
        ),
      ),
    );
  }

  static ElevatedButton cancel({
    required String text,
    void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.boder,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          color: AppColor.text1,
        ),
      ),
    );
  }
}
