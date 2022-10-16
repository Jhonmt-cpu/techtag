import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:techtag/app/modules/register/components/register_first_page.dart';
import 'package:techtag/app/modules/register/components/register_second_page.dart';
import 'package:techtag/app/values/app_colors.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (controller.pageIndex.value == 1) {
                      controller.pageIndex.value = 0;
                    } else {
                      Get.back();
                    }
                  },
                  child: SvgPicture.asset(
                    "assets/icons/back.svg",
                  ),
                ),
                SizedBox(
                  child: Obx(
                    () => Row(
                      children: [
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                            color: controller.pageIndex.value == 0
                                ? AppColors.purple
                                : AppColors.inputs,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                            color: controller.pageIndex.value == 1
                                ? AppColors.purple
                                : AppColors.inputs,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => controller.pageIndex.value == 0
                  ? const RegisterFirstPage()
                  : const RegisterSecondPage(),
            ),
          ],
        ),
      ),
    );
  }
}
