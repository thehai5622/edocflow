import 'dart:async';

import 'package:edocflow/Component/custom_card.dart';
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
          "File",
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
                CustomCard.title(
                        title: "Tổng số file: ",
                        value: controller.totalCount.value.toString())
                    .marginSymmetric(horizontal: 20, vertical: 10),
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
                        return CustomCard.collectionItem(
                            context: context,
                            onTap: () => Get.toNamed(Routes.detailTemplateFile,
                                    arguments: {
                                      "uuid": controller.collection[index].uuid
                                    }),
                            children: [
                              CustomCard.infoRow(
                                  title: "Tên file:",
                                  value:
                                      controller.collection[index].name ?? "--",
                                  isHightlight: true),
                              CustomCard.infoRow(
                                  title: "Loại file:",
                                  value: controller.collection[index]
                                          .typeTemplateFile?.name ??
                                      "--"),
                              CustomCard.infoRow(
                                  title: "Người tạo:",
                                  value:
                                      controller.collection[index].user?.name ??
                                          "--",
                                  isHightlight: true),
                              CustomCard.infoRow(
                                  title: "Ghi chú:",
                                  value: controller.collection[index].note ??
                                      "--"),
                              CustomCard.infoRow(
                                  title: "Khởi tạo:",
                                  value: Utils.formatDate(
                                      isoString: controller
                                          .collection[index].createdAt)),
                              CustomCard.infoRow(
                                  title: "Chỉnh sửa lần cuối:",
                                  value: Utils.formatDate(
                                      isoString: controller
                                          .collection[index].updatedAt)),
                            ],
                            actions: [
                              CustomCard.actionItem(
                                icon: Icons.remove_red_eye,
                                bgColor: AppColor.thirdMain,
                              ),
                              const SizedBox(width: 6),
                              CustomCard.actionItem(
                                icon: Icons.edit,
                                bgColor: AppColor.primary,
                                onTap: () => Get.toNamed(
                                    Routes.upsertTemplateFile,
                                    arguments: {
                                      "uuid": controller.collection[index].uuid
                                    }),
                              ),
                              const SizedBox(width: 6),
                              CustomCard.actionItem(
                                  icon: Icons.delete,
                                  bgColor: AppColor.grey,
                                  onTap: () {
                                    CustomDialog.show(
                                        context: context,
                                        onPressed: () =>
                                            controller.deleteItem(index),
                                        title: "Xóa file mẫu",
                                        content:
                                            "File mẫu '${controller.collection[index].name}' sẽ bị xóa, bạn chắc chứ?");
                                  }),
                            ]);
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
        onPressed: () =>
            Get.toNamed(Routes.upsertTemplateFile, arguments: {"uuid": ""}),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
