import 'dart:io';

import 'package:edocflow/Component/custom_bottomsheet.dart';
import 'package:edocflow/Component/custom_dialog.dart';
import 'package:edocflow/Controller/dashboard_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:edocflow/View/Document/document_in.dart';
import 'package:edocflow/View/Document/document_out.dart';
import 'package:edocflow/View/Home/home.dart';
import 'package:edocflow/View/Individual/individual.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        CustomDialog.show(
            context: context,
            title: "Đóng ứng dụng",
            content: "Ứng dụng sẽ được đóng lại?",
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            });
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        body: Obx(() {
          switch (controller.currentIndex.value) {
            case 0:
              return Home();
            case 1:
              return DocumentIn();
            case 2:
              return DocumentOut();
            case 3:
              return Individual();
            default:
              return Container();
          }
        }),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          shadowColor: AppColor.text1,
          color: AppColor.main,
          shape: const CircularNotchedRectangle(),
          child: Obx(
            () => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Trang Tổng quan
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changePage(0),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/home_hashtag.svg',
                              height: 25,
                              width: 25,
                              colorFilter: controller.currentIndex.value == 0
                                  ? ColorFilter.mode(
                                      AppColor.primary, BlendMode.srcIn)
                                  : null,
                            ),
                            Text(
                              'Tổng quan',
                              textAlign: TextAlign.center,
                              style: controller.currentIndex.value == 0
                                  ? TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w700)
                                  : TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.grey,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Văn bản đến
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changePage(1),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/document.svg',
                              height: 25,
                              width: 25,
                              colorFilter: controller.currentIndex.value == 1
                                  ? ColorFilter.mode(
                                      AppColor.primary, BlendMode.srcIn)
                                  : null,
                            ),
                            Text(
                              'Văn bản đến',
                              textAlign: TextAlign.center,
                              style: controller.currentIndex.value == 1
                                  ? TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w700)
                                  : TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.grey,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Văn bản đi
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changePage(2),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/document.svg',
                              height: 25,
                              width: 25,
                              colorFilter: controller.currentIndex.value == 2
                                  ? ColorFilter.mode(
                                      AppColor.primary, BlendMode.srcIn)
                                  : null,
                            ),
                            Text(
                              'Văn bản đi',
                              textAlign: TextAlign.center,
                              style: controller.currentIndex.value == 2
                                  ? TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w700)
                                  : TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.grey,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Trang Cá nhân
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changePage(3),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/user_octagon.svg',
                              height: 25,
                              width: 25,
                              colorFilter: controller.currentIndex.value == 3
                                  ? ColorFilter.mode(
                                      AppColor.primary, BlendMode.srcIn)
                                  : null,
                            ),
                            Text(
                              'Cá nhân',
                              textAlign: TextAlign.center,
                              style: controller.currentIndex.value == 3
                                  ? TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w700)
                                  : TextStyle(
                                      fontSize: DeviceHelper.getFontSize(15),
                                      color: AppColor.grey,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.primary,
            shape: const CircleBorder(),
            onPressed: () {
              CustomBottomsheet.show(
                context: context,
                child: Column(
                  children: [
                    CustomBottomsheet.item(
                      title: 'Thêm file mẫu',
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.upsertTemplateFile,
                            arguments: {"uuid": ""});
                      },
                    ),
                    CustomBottomsheet.item(
                      title: 'Thêm văn bản đi',
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.upsertDocumentOut,
                            arguments: {"uuid": ""});
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 30,
              color: AppColor.white,
            )),
      ),
    );
  }
}
