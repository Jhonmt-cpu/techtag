import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:techtag/app/components/button.dart';
import 'package:techtag/app/components/complex_text_input.dart';
import 'package:techtag/app/modules/register/controllers/register_controller.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

class RegisterSecondPage extends GetView<RegisterController> {
  const RegisterSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Get.height * 0.23,
        ),
        const Text(
          AppStrings.emailAndPassword,
          style: TextStyle(
            color: AppColors.titles,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 26 / 24,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ComplexTextInput(
          labelText: AppStrings.labelEmail,
          roundBordersTop: true,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter(RegExp('[a-z0-9@.+_-]'), allow: true),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
        ),
        Obx(
          () => ComplexTextInput(
            labelText: AppStrings.labelPassword,
            roundBordersBottom: true,
            obscureButtonValue: controller.obscurePassword.value,
            onTapObscureButton: () {
              controller.obscurePassword(!controller.obscurePassword.value);
            },
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Button(
          enable: true,
          backgroundColor: AppColors.green,
          text: AppStrings.completeRegistration,
          onTap: () {
            controller.pageIndex.value = 0;
          },
        ),
      ],
    );
  }
}
