import 'package:edocflow/Controller/Document/upsert_document_out_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpsertDocumentOut extends StatelessWidget {
  UpsertDocumentOut({super.key});

  final controller = Get.put(UpsertDocumentOutController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        scrolledUnderElevation: 0.0,
        shadowColor: AppColor.text1,
        title: Text(
          controller.title,
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(),
      ),
    );
  }
}
