import 'package:edocflow/Controller/Notification/notification_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notification extends StatelessWidget {
  Notification({super.key});

  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        shadowColor: AppColor.text1,
        title: Text(
          "Thông báo",
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(21),
            color: AppColor.text1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColor.primary,
              ),
            )
          : RefreshIndicator(
              onRefresh: () => controller.refreshData(),
              child: Obx(
                () => ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.only(bottom: 100),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.collection.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.tapItem(index),
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: controller.collection[index].isRead == 0
                                ? AppColor.main
                                : AppColor.boder,
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: AppColor.boder,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.collection[index].title ?? "--",
                                style: TextStyle(
                                  fontSize: DeviceHelper.getFontSize(16),
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.text1,
                                ),
                              ),
                              Text(
                                controller.collection[index].body ?? "--",
                                style: TextStyle(
                                  fontSize: DeviceHelper.getFontSize(14),
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.textHint,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )),
    );
  }
}
