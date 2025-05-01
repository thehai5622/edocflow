import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/time_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CustomField {
  static TextFormField textFormfield({
    TextEditingController? controller,
    String? Function(String?)? validator,
    String? hintText,
    bool? enabled,
    String? label,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      style: TextStyle(
        fontSize: DeviceHelper.getFontSize(15),
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: AppColor.text1,
      ),
      controller: controller,
      enabled: enabled,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        label: Text(
          label ?? "",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(15),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: AppColor.primary,
          ),
        ),
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
        errorStyle: TextStyle(
          color: AppColor.red,
          fontSize: DeviceHelper.getFontSize(14),
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: AppColor.textHint,
          fontSize: DeviceHelper.getFontSize(15),
          fontWeight: FontWeight.w500,
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

  static TextFormField dateField({
    required BuildContext context,
    TextEditingController? controller,
    String? Function(String?)? validator,
    String? hintText,
    bool? enabled,
    String? label,
    FocusNode? focusNode,
  }) {
    DateTime now = DateTime.now();

    return TextFormField(
      style: TextStyle(
        fontSize: DeviceHelper.getFontSize(15),
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: AppColor.text1,
      ),
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.datetime,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9\/]*$')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          String text = newValue.text;
          if (newValue.text.length == 2 && oldValue.text.length != 3) {
            text += '/';
          }
          if (newValue.text.length == 5 && oldValue.text.length != 6) {
            text += '/';
          }
          return newValue.copyWith(
              text: text,
              selection: TextSelection.collapsed(offset: text.length));
        })
      ],
      focusNode: focusNode,
      decoration: InputDecoration(
        label: Text(
          label ?? "",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(15),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: AppColor.primary,
          ),
        ),
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
        errorStyle: TextStyle(
          color: AppColor.red,
          fontSize: DeviceHelper.getFontSize(14),
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: AppColor.textHint,
          fontSize: DeviceHelper.getFontSize(15),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText ?? 'dd/mm/yyyy',
        contentPadding: const EdgeInsets.only(left: 16, right: 16),
        suffixIcon: GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColor.primary,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                    ),
                    // dialogBackgroundColor: Colors.orangeAccent, // Nền của toàn dialog
                  ),
                  child: child!,
                );
              },
              context: context,
              initialDate:
                  TimeHelper.stringToDate(controller?.text ?? "") ?? now,
              firstDate: DateTime(now.year - 100, now.month, now.day),
              lastDate: DateTime(now.year + 100, now.month, now.day),
            );
            if (pickedDate != null) {
              controller?.text = DateFormat('dd/MM/yyyy').format(pickedDate);
            }
          },
          child: SvgPicture.asset(
            "assets/icons/calendar.svg",
            colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
            fit: BoxFit.scaleDown,
            height: 20,
            width: 20,
          ),
        ),
      ),
      onChanged: (value) => {},
      validator: validator,
    );
  }
}
