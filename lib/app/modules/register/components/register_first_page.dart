import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:techtag/app/components/button.dart';
import 'package:techtag/app/components/complex_text_input.dart';
import 'package:techtag/app/modules/register/controllers/register_controller.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

class RegisterFirstPage extends GetView<RegisterController> {
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 18,
        ),
        const Text(
          AppStrings.whoAreYou,
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
        Obx(
          () => ComplexTextInput(
            labelText: AppStrings.labelFullName,
            roundBordersTop: true,
            errorText: controller.nameError.value,
            textEditingController: controller.nameController,
            inputFormatters: [
              FilteringTextInputFormatter(
                RegExp(r"[A-Za-zÀ-ÖØ-öø-ÿ0-9'\s]"),
                allow: true,
              ),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            textInputAction: TextInputAction.next,
            onChanged: (text) => controller.checkName(text),
          ),
        ),
        Obx(
          () => ComplexTextInput(
            labelText: AppStrings.labelPhone,
            textEditingController: controller.phoneNumberController,
            errorText: controller.phoneError.value,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              MobilePhoneNumberInputFormatter(),
              FilteringTextInputFormatter.singleLineFormatter
            ],
            onChanged: (text) => controller.checkPhoneNumber(text),
          ),
        ),
        Obx(
          () => ComplexTextInput(
            labelText: AppStrings.labelBirthDate,
            textInputAction: TextInputAction.next,
            errorText: controller.birthDayError.value,
            textEditingController: controller.birthDayController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              DateInputFormatter(),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            onChanged: (text) => controller.checkBirthday(text),
          ),
        ),
        Obx(
          () => ComplexTextInput(
            labelText: AppStrings.labelCpf,
            textEditingController: controller.cpfController,
            errorText: controller.cpfError.value,
            roundBordersBottom: true,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            inputFormatters: [
              CpfInputFormatter(),
              FilteringTextInputFormatter.singleLineFormatter,
            ],
            onChanged: (text) => controller.checkCpf(text),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Button(
          enable: true,
          backgroundColor: AppColors.purple,
          text: AppStrings.next,
          onTap: () => controller.goToSecondPage(),
        ),
      ],
    );
  }
}
