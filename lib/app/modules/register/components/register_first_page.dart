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
        ComplexTextInput(
          labelText: AppStrings.labelFullName,
          roundBordersTop: true,
          inputFormatters: [
            FilteringTextInputFormatter(
              RegExp(r"[A-Za-zÀ-ÖØ-öø-ÿ0-9'\s]"),
              allow: true,
            ),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          textInputAction: TextInputAction.next,
        ),
        ComplexTextInput(
          labelText: AppStrings.labelPhone,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            MobilePhoneNumberInputFormatter(),
            FilteringTextInputFormatter.singleLineFormatter
          ],
        ),
        ComplexTextInput(
          labelText: AppStrings.labelBirthDate,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: [
            DateInputFormatter(),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
        ),
        ComplexTextInput(
          labelText: AppStrings.labelCpf,
          roundBordersBottom: true,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          inputFormatters: [
            CpfInputFormatter(),
            FilteringTextInputFormatter.singleLineFormatter,
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Button(
          enable: true,
          backgroundColor: AppColors.purple,
          text: AppStrings.next,
          onTap: () {
            controller.pageIndex.value = 1;
          },
        ),
      ],
    );
  }
}
