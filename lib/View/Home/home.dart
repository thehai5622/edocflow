import 'package:edocflow/Component/document_single_chart.dart';
import 'package:edocflow/Controller/Home/home_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Model/dashboard.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        shadowColor: AppColor.text1,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  controller.avatar.value,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 40),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chào mừng",
                  style: TextStyle(
                    color: AppColor.textHint,
                    fontSize: DeviceHelper.getFontSize(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.name.value,
                    style: TextStyle(
                        fontSize: DeviceHelper.getFontSize(17),
                        fontWeight: FontWeight.w700,
                        color: AppColor.text1),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.notification),
              icon: Icon(
                Icons.notifications,
                size: 20,
                color: AppColor.text1,
              )),
          const SizedBox(width: 12),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                    color: AppColor.primary, strokeWidth: 2),
              )
            : RefreshIndicator(
                onRefresh: () => controller.refreshData(),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    DocumentSingleChart(
                      statusData: controller.detail.documentIn!.toStatusMap(),
                    ),
                    DocumentSingleChart(
                      statusData: controller.detail.documentOut!.toStatusMap(),
                    ),
                    const SizedBox(height: 125),
                  ],
                ),
              ),
      ),
    );
  }
}
