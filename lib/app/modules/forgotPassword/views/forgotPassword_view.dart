import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:techtag/app/components/button.dart';
import 'package:techtag/app/components/complex_text_input.dart';
import 'package:techtag/app/components/progress_overlay.dart';
import 'package:techtag/app/routes/app_pages.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

import '../controllers/forgotPassword_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.purple,
          ),
          backgroundColor: AppColors.background,
          body: ListView(
            children: [
              Container(
                height: 270,
                width: Get.width,
                color: AppColors.purple,
                child: SvgPicture.asset(
                  "assets/icons/backgroundLogin.svg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 56,
                  right: 32,
                  left: 32,
                  bottom: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    const Text(
                      AppStrings.forgot,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titles,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      AppStrings.textForgot,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.base,
                      ),                   ),
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(
                      () => ComplexTextInput(
                        labelText: AppStrings.labelEmail,
                        roundBordersTop: true,
                        roundBordersBottom: true,
                        textEditingController: controller.emailController,
                        errorText: controller.emailError.value,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp('[a-z0-9@.+_-]'), allow: true),
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        onChanged: (text) => controller.checkEmail(text),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 24),
                      ),
                    ),
                    Button(
                      enable: true,
                      backgroundColor: AppColors.green,
                      text: AppStrings.getIn,
                      onTap: () => controller.forgot(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Obx(() => controller.isLoading.value ? const ProgressOverlay() : const SizedBox()),
      ],
    );
  }
}
