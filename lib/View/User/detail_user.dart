import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/User/detail_user_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailUser extends StatelessWidget {
  DetailUser({super.key});

  final controller = Get.put(DetailUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        shadowColor: AppColor.text1,
        title: Text(
          "Chi tiết cán bộ",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: AppColor.primary,
                strokeWidth: 2,
              ))
            : ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "${controller.baseUrl}${controller.detail.avatar}",
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.white,
                          ),
                          child: const Icon(Icons.person, size: 180),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomField.titleForm(title: "Mã cán bộ:"),
                  _detailValue(
                    value: controller.detail.uuid,
                    isHightlight: true,
                  ).marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Tên cán bộ:"),
                  _detailValue(value: controller.detail.name)
                      .marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Giới tính:"),
                  _detailValue(
                          value: controller.detail.gender == 1 ? "Nam" : "Nữ")
                      .marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Ngày sinh:"),
                  _detailValue(
                      value: Utils.formatDate(
                    isoString: controller.detail.birthDay,
                    isDateOnly: true,
                  )).marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Quyền hành:"),
                  _detailValue(value: controller.detail.permission?.name)
                      .marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Thuộc cơ quan:"),
                  _detailValue(value: controller.detail.issuingAuthority?.name)
                      .marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Điện thoại:"),
                  _detailValue(value: controller.detail.phone)
                      .marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Email:"),
                  _detailValue(value: controller.detail.email)
                      .marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Ngày tạo:"),
                  _detailValue(
                      value: Utils.formatDate(
                    isoString: controller.detail.createdAt,
                  )).marginSymmetric(vertical: 8, horizontal: 16),
                  CustomField.titleForm(title: "Chỉnh sửa lần cuối:"),
                  _detailValue(
                      value: Utils.formatDate(
                    isoString: controller.detail.updatedAt,
                  )).marginSymmetric(vertical: 8, horizontal: 16),
                ],
              ),
      ),
    );
  }

  Text _detailValue(
      {String? value, bool isHightlight = false, bool isStatus = false}) {
    return Text(
      value ?? "--",
      style: TextStyle(
        fontSize: DeviceHelper.getFontSize(15),
        color: isStatus
            ? Colors.white
            : isHightlight
                ? AppColor.primary
                : AppColor.text1,
        fontWeight: isHightlight ? FontWeight.w600 : FontWeight.w500,
      ),
    );
  }
}
