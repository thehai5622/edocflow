import 'package:edocflow/Controller/IssuingAuthority/create_ia_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateIssuingAuthority extends StatelessWidget {
  CreateIssuingAuthority({super.key});

  final controller = Get.put(CreateIssuingAuthorityController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.subMain,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        leading: GestureDetector(
            onTap: () => controller.back(),
            child: Icon(Icons.close, color: AppColor.text1, size: 21)),
        shadowColor: AppColor.text1,
        title: Text(
          "Tạo cơ quan ban hành",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    color: AppColor.main,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        _titleForm(title: "Tên cơ quan ban hành", isRequired: true)
                            .marginSymmetric(horizontal: 20),
                        TextFormField(
                          controller: controller.name,
                          style: TextStyle(
                            fontSize: DeviceHelper.getFontSize(15),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            color: AppColor.text1,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  BorderSide(width: 1, color: AppColor.subMain),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  BorderSide(width: 1, color: AppColor.subMain),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            hintStyle: TextStyle(
                              color: AppColor.grey,
                              fontSize: DeviceHelper.getFontSize(15),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'Nhập tên cơ quan ban hành',
                            contentPadding:
                                const EdgeInsets.only(left: 16, right: 16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng nhập cơ quan ban hành";
                            }
                            return null;
                          },
                        ).marginSymmetric(horizontal: 20, vertical: 6),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.main,
              ),
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.fourthMain,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.isWaitSubmit.value
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            controller.submit();
                          }
                        },
                  child: Text(
                    'Lưu lại',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: DeviceHelper.getFontSize(14),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _titleForm({
    required String title,
    isRequired = false,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: DeviceHelper.getFontSize(16),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF535763),
            ),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(
                fontSize: DeviceHelper.getFontSize(15),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF0000),
              ),
            )
        ],
      ),
    );
  }
}
