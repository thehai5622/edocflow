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
      backgroundColor: AppColor.background,
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
                  children: [
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.boder,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Obx(
                              () => _fillter(
                                  label: "Thời gian",
                                  value: controller.timeFilter.value,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: AppColor.white,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: controller.listTimeFilter
                                                .map((filter) {
                                              bool isSelected = filter.value ==
                                                  controller.timeFilterValue;
                                              return GestureDetector(
                                                onTap: () => controller.onTapTimeFilter(filter),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 12),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                      width: 1,
                                                      color: AppColor.boder,
                                                    )),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        filter.title,
                                                        style: TextStyle(
                                                          color: isSelected
                                                              ? AppColor.primary
                                                              : AppColor.text1,
                                                          fontSize: DeviceHelper
                                                              .getFontSize(14),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      isSelected
                                                          ? Icon(
                                                              Icons.check,
                                                              color: AppColor
                                                                  .primary,
                                                              size: 20,
                                                            )
                                                          : const SizedBox(
                                                              width: 20,
                                                              height: 20,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                            ),
                            _fillter(
                                label: "khoảng thời gian", value: "Tất cả"),
                            _fillter(
                              label: "Cơ quan ban hành",
                              value: "Tất cả",
                              isHaveBottomBoder: false,
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          Text(
                            "Thống kê văn bản đến",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.text1,
                              fontSize: DeviceHelper.getFontSize(17),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DocumentSingleChart(
                            statusData:
                                controller.detail.documentIn!.toStatusMap(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      color: AppColor.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          Text(
                            "Thống kê văn bản đi",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.text1,
                              fontSize: DeviceHelper.getFontSize(17),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DocumentSingleChart(
                            statusData:
                                controller.detail.documentOut!.toStatusMap(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
      ),
    );
  }

  GestureDetector _fillter({
    required String label,
    required String value,
    bool isHaveBottomBoder = true,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isHaveBottomBoder
              ? Border(
                  bottom: BorderSide(
                    width: 1,
                    color: AppColor.boder,
                  ),
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColor.text1,
                fontSize: DeviceHelper.getFontSize(14),
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: AppColor.text1,
                    fontSize: DeviceHelper.getFontSize(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                  color: AppColor.text1,
                ),
              ],
            ),
          ],
        ).marginSymmetric(vertical: 12),
      ),
    );
  }
}
