import 'dart:async';

import 'package:edocflow/Component/custom_button.dart';
import 'package:edocflow/Component/custom_card.dart';
import 'package:edocflow/Component/custom_dialog.dart';
import 'package:edocflow/Component/custom_field.dart';
import 'package:edocflow/Component/custom_listview.dart';
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
  final _formKey = GlobalKey<FormState>();

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
                              onTap: () =>
                                  _update(context: context, index: index),
                            ),
                            const SizedBox(width: 6),
                            controller.collection[index].username == null
                                ? CustomCard.actionItem(
                                    icon: Icons.account_circle,
                                    bgColor: AppColor.secondary,
                                    onTap: () {
                                      {
                                        _provideAccount(
                                            context: context, index: index);
                                      }
                                    },
                                  )
                                : CustomCard.actionItem(
                                    icon: Icons.abc,
                                    bgColor: AppColor.secondary,
                                    onTap: () {
                                      {
                                        CustomDialog.show(
                                            context: context,
                                            onPressed: () =>
                                                controller.resetPassword(index),
                                            title: "Cấp lại mật khẩu",
                                            content:
                                                "Cán bộ '${controller.collection[index].name}' sẽ được cấp lại mật khẩu mặc định là '123456', bạn chắc chứ?");
                                      }
                                    },
                                  ),
                            const SizedBox(width: 6),
                            CustomCard.actionItem(
                                icon: controller.collection[index].status == 1
                                    ? Icons.lock
                                    : Icons.lock_open,
                                bgColor: AppColor.grey,
                                onTap: () {
                                  CustomDialog.show(
                                      context: context,
                                      onPressed: () =>
                                          controller.collection[index].status ==
                                                  1
                                              ? controller.lockItem(index)
                                              : controller.unlockItem(index),
                                      title:
                                          "${controller.collection[index].status == 1 ? "Khóa" : "Mở khóa"} cán bộ này",
                                      content:
                                          "${controller.collection[index].status == 1 ? "Khóa" : "Mở khóa"} cán bộ '${controller.collection[index].name}', bạn chắc chứ?");
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

  _update({required BuildContext context, required int index}) {
    controller.selectedPUUID =
        controller.collection[index].permission?.uuid ?? -1;
    controller.pName.text =
        controller.collection[index].permission?.name ?? "--";
    controller.selectedIAUUID =
        controller.collection[index].issuingAuthority?.uuid ?? "";
    controller.iaName.text =
        controller.collection[index].issuingAuthority?.name ?? "--";
    CustomDialog.dialogEmpty(
      context: context,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Cập nhật quyền / Cơ quan ban hành",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.text1,
                  fontWeight: FontWeight.w700,
                  fontSize: DeviceHelper.getFontSize(20)),
            ),
            const SizedBox(height: 20),
            CustomField.titleForm(title: "Quyền", isRequired: true)
                .marginSymmetric(horizontal: 20),
            CustomField.dropDownField(
              context: context,
              onTap: controller.initP,
              funcGetAndSearch: controller.getPCollection,
              controller: controller.pName,
              searchController: controller.searchP,
              enabled: true,
              hintText: "Chọn quyền của cán bộ",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Quyền là trường bắt buộc";
                }
                return null;
              },
              child: Obx(
                () => controller.isLoadingP.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColor.primary,
                        strokeWidth: 2,
                      ))
                    : CustomListView.show(
                        itemCount: controller.pCollection.length,
                        gap: 0,
                        itemBuilder: (context, index) =>
                            CustomListView.viewItem(
                          onTap: () {
                            if (controller.selectedPUUID !=
                                controller.pCollection[index].uuid) {
                              Get.back();
                              controller.pName.text =
                                  controller.pCollection[index].name ?? "--";
                              controller.selectedPUUID =
                                  controller.pCollection[index].uuid ?? -1;
                            }
                          },
                          title: controller.pCollection[index].name,
                          isSelected: controller.selectedPUUID ==
                              controller.pCollection[index].uuid,
                        ),
                      ),
              ),
            ).marginSymmetric(horizontal: 20, vertical: 6),
            CustomField.titleForm(title: "Thuộc cơ quan", isRequired: true)
                .marginSymmetric(horizontal: 20),
            CustomField.dropDownField(
              context: context,
              onTap: controller.initIA,
              funcGetAndSearch: controller.getIACollection,
              controller: controller.iaName,
              searchController: controller.searchIA,
              enabled: true,
              hintText: "Chọn cơ quan ban hành",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Cơ quan là trường bắt buộc";
                }
                return null;
              },
              child: Obx(
                () => controller.isLoadingIA.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColor.primary,
                        strokeWidth: 2,
                      ))
                    : CustomListView.show(
                        itemCount: controller.iaCollection.length,
                        gap: 0,
                        itemBuilder: (context, index) =>
                            CustomListView.viewItem(
                          onTap: () {
                            if (controller.selectedIAUUID !=
                                controller.iaCollection[index].uuid) {
                              Get.back();
                              controller.iaName.text =
                                  controller.iaCollection[index].name ?? "--";
                              controller.selectedIAUUID =
                                  controller.iaCollection[index].uuid ?? "";
                            }
                          },
                          title: controller.iaCollection[index].name,
                          isSelected: controller.selectedIAUUID ==
                              controller.iaCollection[index].uuid,
                        ),
                      ),
              ),
            ).marginSymmetric(horizontal: 20, vertical: 6),
            Row(
              children: [
                Expanded(
                  child: CustomButton.cancel(
                    text: "Hủy bỏ",
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton.primary(
                    text: "Xác nhận",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        controller.updateItem(index);
                      }
                    },
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 16),
          ],
        ),
      ),
    );
  }

  _provideAccount({required BuildContext context, required int index}) {
    controller.username.text = "";
    CustomDialog.dialogEmpty(
      context: context,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Cấp tài khoản",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.text1,
                    fontWeight: FontWeight.w700,
                    fontSize: DeviceHelper.getFontSize(20)),
              ),
            ),
            const SizedBox(height: 20),
            CustomField.titleForm(title: "Tài khoản", isRequired: true)
                .marginSymmetric(horizontal: 20),
            CustomField.textFormfield(
                controller: controller.username,
                hintText: "Tài khoản",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tài khoản là bắt buộc";
                  }
                  return null;
                }).marginSymmetric(horizontal: 20, vertical: 6),
            Text(
              "Mật khẩu mặc định sẽ là 123456",
              style: TextStyle(
                color: AppColor.textHint,
                fontSize: DeviceHelper.getFontSize(14),
                fontWeight: FontWeight.w500,
              ),
            ).marginSymmetric(horizontal: 20, vertical: 6),
            Row(
              children: [
                Expanded(
                  child: CustomButton.cancel(
                    text: "Hủy bỏ",
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton.primary(
                    text: "Xác nhận",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        controller.provideAccount(index);
                      }
                    },
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 16),
          ],
        ),
      ),
    );
  }
}
