import 'dart:async';

import 'package:edocflow/Component/custom_card.dart';
import 'package:edocflow/Component/custom_dialog.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Controller/Document/document_in_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Global/document_status.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DocumentIn extends StatelessWidget {
  DocumentIn({super.key});

  final controller = Get.put(DocumentInController());

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
          "Văn bản đến",
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: AppColor.main,
                  child: CustomField.textFormfield(
                    controller: controller.searchController.value,
                    hintText: "Nhập từ khóa tìm kiếm",
                    prefixIcon:
                        Icon(Icons.search, color: AppColor.text1, size: 20),
                    onChanged: (value) => {
                      controller.isShowClearText.value = value.isNotEmpty,
                      if (controller.debounceTimer != null)
                        {controller.debounceTimer!.cancel()},
                      controller.debounceTimer =
                          Timer(const Duration(milliseconds: 500), () {
                        controller.getData();
                      })
                    },
                    suffix: Obx(
                      () => controller.isShowClearText.value
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
                          : const SizedBox(width: 0),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/filter.svg",
                          height: 20,
                          width: 20,
                          fit: BoxFit.scaleDown,
                          colorFilter:
                              ColorFilter.mode(AppColor.text1, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomCard.title(
                        title: "Tổng số văn bản đến",
                        value: controller.totalCount.value.toString())
                    .marginSymmetric(horizontal: 20, vertical: 10),
                Expanded(
                    child: RefreshIndicator(
                  onRefresh: () => controller.refreshData(),
                  child: Obx(
                    () => ListView.separated(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.only(bottom: 120),
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: controller.collection.length,
                      itemBuilder: (context, index) {
                        return CustomCard.collectionItem(
                          context: context,
                          onTap: () =>
                              Get.toNamed(Routes.detailDocument, arguments: {
                            "uuid": controller.collection[index].uuid,
                            "document": "in",
                          }),
                          status: DocumentStatus.getTextStatus(
                            controller.collection[index].status ?? 0,
                          ),
                          stausColor: DocumentStatus.getColorStatus(
                            controller.collection[index].status ?? 0,
                          ),
                          children: [
                            CustomCard.infoRow(
                                title: "Mã văn bản:",
                                value:
                                    controller.collection[index].uuid ?? "--",
                                isHightlight: true),
                            CustomCard.infoRow(
                                title: "Trích yếu:",
                                value: controller.collection[index].summary ??
                                    "--"),
                            CustomCard.infoRow(
                                title: "Số hiệu:",
                                value: controller
                                        .collection[index].referenceNumber ??
                                    "--",
                                isHightlight: true),
                            CustomCard.infoRow(
                                title: "Từ cơ quan:",
                                value: controller.collection[index]
                                        .fromIssuingauthority?.name ??
                                    "--"),
                            CustomCard.infoRow(
                                title: "Người tạo:",
                                value:
                                    controller.collection[index].user?.name ??
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
                            if (controller.collection[index].status == 1)
                              Row(
                                children: [
                                  const SizedBox(width: 6),
                                  CustomCard.actionItem(
                                      icon: Icons.delete,
                                      bgColor: AppColor.grey,
                                      onTap: () {
                                        CustomDialog.show(
                                            context: context,
                                            onPressed: () =>
                                                controller.deleteItem(index),
                                            title: "Hủy văn bản đến",
                                            content:
                                                "Văn bản đến '${controller.collection[index].uuid}' sẽ bị hủy, bạn chắc chứ?");
                                      }),
                                ],
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                )),
              ],
            )),
    );
  }
}
