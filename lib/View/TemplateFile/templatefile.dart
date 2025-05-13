import 'dart:async';

import 'package:edocflow/Component/custom_dialog.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/TemplateFile/templatefile_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemplateFile extends StatelessWidget {
  TemplateFile({super.key});

  final controller = Get.put(TemplateFileController());

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
          "File mẫu",
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
          : Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    color: AppColor.main,
                    child: CustomField.textFormfield(
                        controller: controller.searchController.value,
                        hintText: "Nhập từ khóa tìm kiếm",
                        prefixIcon:
                            Icon(Icons.search, color: AppColor.text1, size: 20),
                        onChanged: (value) => {
                              controller.isShowClearText.value =
                                  value.isNotEmpty,
                              if (controller.debounceTimer != null)
                                {controller.debounceTimer!.cancel()},
                              controller.debounceTimer =
                                  Timer(const Duration(milliseconds: 500), () {
                                controller.getData();
                              })
                            },
                        suffixIcon: Obx(() => controller.isShowClearText.value
                            ? GestureDetector(
                                onTap: () {
                                  controller.isShowClearText.value = false;
                                  controller.searchController.value.clear();
                                  if (controller.debounceTimer != null) {
                                    controller.debounceTimer!.cancel();
                                  }
                                  controller.debounceTimer = Timer(
                                      const Duration(milliseconds: 500), () {
                                    controller.getData();
                                  });
                                },
                                child: Icon(Icons.close,
                                    color: AppColor.text1, size: 20))
                            : const SizedBox(width: 0)))),
                Text(
                  "-------   Tổng số file mẫu: ${controller.totalCount.value}   -------",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: DeviceHelper.getFontSize(17),
                    color: AppColor.text1,
                    fontWeight: FontWeight.w700,
                  ),
                ).marginSymmetric(horizontal: 20, vertical: 10),
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: () => controller.refreshData(),
                  child: Obx(
                    () => ListView.separated(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.only(bottom: 100),
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: controller.collection.length,
                      itemBuilder: (context, index) {
                        return _collectionItem(context: context, index: index);
                      },
                    ),
                  ),
                )),
              ],
            )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: () => Get.toNamed(Routes.createIa),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  GestureDetector _collectionItem(
      {required BuildContext context, required int index}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.main,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 2,
                color: AppColor.background,
              ))),
              child: Column(
                children: [
                  _infoRow(
                      title: "Tên file mẫu:",
                      value: controller.collection[index].name ?? "--",
                      isHightlight: true),
                  _infoRow(
                      title: "Loại file mẫu:",
                      value:
                          controller.collection[index].typeTemplateFile?.name ??
                              "--"),
                  _infoRow(
                      title: "Người tạo:",
                      value: controller.collection[index].user?.name ?? "--",
                      isHightlight: true),
                  _infoRow(
                      title: "Ghi chú:",
                      value: controller.collection[index].note ?? "--"),
                  _infoRow(
                      title: "Khởi tạo:",
                      value: Utils.formatDate(
                          controller.collection[index].createdAt)),
                  _infoRow(
                      title: "Chỉnh sửa lần cuối:",
                      value: Utils.formatDate(
                          controller.collection[index].updatedAt)),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _actionItem(
                  icon: Icons.edit,
                  bgColor: AppColor.primary,
                  onTap: () => Get.toNamed(Routes.editIa,
                      arguments: controller.collection[index]),
                ),
                const SizedBox(width: 6),
                _actionItem(
                    icon: Icons.delete,
                    bgColor: AppColor.grey,
                    onTap: () {
                      CustomDialog.show(
                          context: context,
                          onPressed: () => controller.deleteItem(index),
                          title: "Xóa file mẫu",
                          content:
                              "File mẫu '${controller.collection[index].name}' sẽ bị xóa, bạn chắc chứ?");
                    }),
              ],
            ).marginOnly(right: 12, bottom: 10)
          ],
        ),
      ),
    );
  }

  GestureDetector _actionItem(
      {void Function()? onTap,
      required Color bgColor,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
        child: Icon(icon, color: AppColor.white, size: 17),
      ),
    );
  }

  Row _infoRow(
      {required String title,
      required String value,
      bool isHightlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: DeviceHelper.getFontSize(15),
            color: AppColor.text1,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: DeviceHelper.getFontSize(15),
              color: isHightlight ? AppColor.primary : AppColor.text1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
