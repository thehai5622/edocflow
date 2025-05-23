import 'dart:async';

import 'package:edocflow/Component/custom_card.dart';
import 'package:edocflow/Component/custom_dialog.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/User/user_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class User extends StatelessWidget {
  User({super.key});

  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.main,
        shadowColor: AppColor.text1,
        title: Text(
          "Cán bộ",
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
                        title: "Tổng số cán bộ",
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
                          onTap: () => Get.toNamed(Routes.detailUser,
                              arguments: {
                                "uuid": controller.collection[index].uuid
                              }),
                          context: context,
                          image:
                              "${controller.imageBaseUrl}${controller.collection[index].avatar}",
                          children: [
                            CustomCard.infoRow(
                                title: "Mã cán bộ:",
                                value:
                                    controller.collection[index].uuid ?? "--",
                                isHightlight: true),
                            CustomCard.infoRow(
                                title: "Tên cán bộ:",
                                value:
                                    controller.collection[index].name ?? "--",
                                isHightlight: true),
                            CustomCard.infoRow(
                                title: "Thuộc cơ quan:",
                                value: controller.collection[index]
                                        .issuingAuthority?.name ??
                                    "--",
                                isHightlight: false),
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
                                onTap: () {}),
                            if (controller.collection[index].username == null)
                              Row(
                                children: [
                                  const SizedBox(width: 6),
                                  CustomCard.actionItem(
                                    icon: Icons.account_circle,
                                    bgColor: AppColor.secondary,
                                    onTap: () {
                                      {
                                        CustomDialog.show(
                                            context: context,
                                            onPressed: () =>
                                                controller.deleteItem(index),
                                            title: "Cấp tài khoản",
                                            content:
                                                "Cán bộ '${controller.collection[index].name}' sẽ được cấp tài khoản để truy cập hệ thống, tiếp tục điều hướng sang 'Cấp tài khoản'?");
                                      }
                                    },
                                  ),
                                ],
                              ),
                            const SizedBox(width: 6),
                            CustomCard.actionItem(
                                icon: Icons.lock,
                                bgColor: AppColor.grey,
                                onTap: () {
                                  CustomDialog.show(
                                      context: context,
                                      onPressed: () =>
                                          controller.deleteItem(index),
                                      title: "Khóa cán bộ này",
                                      content:
                                          "Cán bộ '${controller.collection[index].name}' sẽ bị khóa, bạn chắc chứ?");
                                }),
                          ],
                        );
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
        onPressed: () => Get.toNamed(Routes.createUser),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
