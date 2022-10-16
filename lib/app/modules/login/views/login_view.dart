import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:techtag/app/components/button.dart';
import 'package:techtag/app/components/complex_text_input.dart';
import 'package:techtag/app/routes/app_pages.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          Container(
            height: 379,
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.login,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titles,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                      child: const Text(
                        AppStrings.createAccount,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ComplexTextInput(
                  labelText: AppStrings.labelEmail,
                  errorText: "Teste Error",
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: GestureDetector(
                      onTap: () {
                        print("oie");
                      },
                      child: const Text(
                        AppStrings.forgotPassword,
                        style: TextStyle(
                          color: AppColors.complements,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 24 / 12,
                        ),
                      ),
                    ),
                  ),
                ),
                Button(
                  enable: true,
                  backgroundColor: AppColors.green,
                  text: AppStrings.getIn,
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
