import 'package:edocflow/Component/custom_dialog.dart';
import 'package:edocflow/Controller/Individual/individual_controller.dart';
import 'package:edocflow/Global/app_color.dart';
import 'package:edocflow/Route/app_page.dart';
import 'package:edocflow/Service/auth.dart';
import 'package:edocflow/Utils/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Individual extends StatelessWidget {
  Individual({super.key});

  final controller = Get.put(IndividualController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.width * 0.4),
          child: SafeArea(
            child: Container(
              color: AppColor.primary,
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/images/document.png",
                fit: BoxFit.cover,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          controller.avatar.value,
                          height: Get.width * 0.2,
                          width: Get.width * 0.2,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.person, size: Get.width * 0.2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(
                        controller.name.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: DeviceHelper.getFontSize(24),
                            fontWeight: FontWeight.w600,
                            color: AppColor.text1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _itemRow(
                    title: "Hồ sơ cá nhân",
                    icon: "assets/icons/user-edit.svg",
                    onTap: () => Get.toNamed(Routes.profile),
                  ),
                  _itemRow(
                    title: "Cơ quan ban hành",
                    icon: "assets/icons/shield-security.svg",
                    onTap: () => Get.toNamed(Routes.issuingAuthority),
                  ),
                  _itemRow(
                    title: "Lĩnh vực",
                    icon: "assets/icons/shield-security.svg",
                    onTap: () => Get.toNamed(Routes.field),
                  ),
                  _itemRow(
                    title: "Loại file mẫu",
                    icon: "assets/icons/shield-security.svg",
                    onTap: () => Get.toNamed(Routes.typeTemplateFile),
                  ),
                  _itemRow(
                    title: "Đổi mật khẩu",
                    icon: "assets/icons/shield-security.svg",
                    onTap: () => Get.toNamed(Routes.changePass),
                  ),
                  _itemRow(
                    title: "Đăng xuất",
                    icon: "assets/icons/logout.svg",
                    onTap: () => CustomDialog.show(
                      context: context,
                      title: "Đăng xuất",
                      content: "Bạn có chắc muốn đăng xuất khỏi ứng dụng?",
                      onPressed: () {
                        Navigator.pop(context);
                        Auth.backLogin(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _itemRow({
    required String title,
    required String icon,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2, color: AppColor.background))),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(icon,
                      height: 20,
                      width: 20,
                      colorFilter:
                          ColorFilter.mode(AppColor.primary, BlendMode.srcIn)),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: DeviceHelper.getFontSize(16),
                        fontWeight: FontWeight.w500,
                        color: AppColor.text1),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: AppColor.primary,
            )
          ],
        ),
      ),
    );
  }
}
