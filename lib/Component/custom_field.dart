import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/time_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CustomField {
  static final TextStyle _hintStyle = TextStyle(
    color: AppColor.textHint,
    fontSize: DeviceHelper.getFontSize(15),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle labelStyle = TextStyle(
    fontSize: DeviceHelper.getFontSize(15),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: AppColor.grey,
  );

  static final TextStyle _textStyle = TextStyle(
    fontSize: DeviceHelper.getFontSize(15),
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: AppColor.text1,
  );

  static final TextStyle _errorStyle = TextStyle(
    color: AppColor.red,
    fontSize: DeviceHelper.getFontSize(14),
    fontWeight: FontWeight.w500,
  );

  static final _outlineBoder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(
      width: 1,
      color: AppColor.boder,
    ),
  );

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
      style: _textStyle,
      controller: controller,
      enabled: enabled,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      cursorColor: AppColor.primary,
      decoration: InputDecoration(
        label: Text(
          label ?? "",
          style: labelStyle,
        ),
        border: _outlineBoder,
        focusColor: AppColor.primary,
        enabledBorder: _outlineBoder,
        disabledBorder: _outlineBoder,
        errorBorder: _outlineBoder,
        focusedBorder: _outlineBoder,
        filled: true,
        fillColor: enabled == true ? AppColor.white : AppColor.boder,
        errorStyle: _errorStyle,
        hintStyle: _hintStyle,
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
      style: _textStyle,
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
      cursorColor: AppColor.primary,
      decoration: InputDecoration(
        label: Text(
          label ?? "",
          style: labelStyle,
        ),
        focusColor: AppColor.primary,
        border: _outlineBoder,
        enabledBorder: _outlineBoder,
        disabledBorder: _outlineBoder,
        errorBorder: _outlineBoder,
        focusedBorder: _outlineBoder,
        filled: true,
        fillColor: enabled == true ? AppColor.white : AppColor.boder,
        errorStyle: _errorStyle,
        hintStyle: _hintStyle,
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
            colorFilter: ColorFilter.mode(AppColor.grey, BlendMode.srcIn),
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

  static Row radioButton({
    required dynamic value,
    required dynamic groupValue,
    required void Function(dynamic)? onChanged,
    bool? enabled,
    String? label,
  }) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: enabled == true ? onChanged : null,
          fillColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColor.primary.withOpacity(.32);
            }
            return AppColor.primary;
          }),
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        if (label != null)
          Row(
            children: [
              const SizedBox(width: 2),
              GestureDetector(
                  onTap: enabled == true ? () => onChanged?.call(value) : null,
                  child: Text(label, style: _textStyle)),
            ],
          ),
      ],
    );
  }
}
