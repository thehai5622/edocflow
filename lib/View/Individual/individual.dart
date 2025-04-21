import 'package:edocflow/Controller/Individual/individual_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Individual extends StatelessWidget {
  Individual({super.key});

  final controller = Get.put(IndividualController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.subMain,
      // appBar: ,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Obx(
              () => Text(
                controller.name.value,
              ),
            ),
          )
        ],
      ),
    );
  }
}