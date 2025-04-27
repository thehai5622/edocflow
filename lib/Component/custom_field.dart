import 'package:edocflow/Global/app_color.dart';
import 'package:flutter/material.dart';

class CustomField {
  static TextFormField textformfield({
    TextEditingController? controller,
    String? Function(String?)? validator,
    String? hintText,
    bool? enabled,
  }) {
    return TextFormField(
      style: TextStyle(
        fontSize: 13,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        color: AppColor.text1,
      ),
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: AppColor.boder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: AppColor.boder,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: AppColor.boder,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: AppColor.boder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: 1,
            color: AppColor.boder,
          ),
        ),
        filled: true,
        fillColor: enabled == true ? AppColor.white : AppColor.boder,
        hintStyle: TextStyle(
          color: AppColor.textHint,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
      ),
      validator: validator,
    );
  }
}
