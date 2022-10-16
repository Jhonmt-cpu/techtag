import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtag/app/values/app_strings.dart';

class RegisterController extends GetxController {
  RxInt pageIndex = 0.obs;

  RxString nameError = "".obs;
  RxString phoneError = "".obs;
  RxString birthDayError = "".obs;
  RxString cpfError = "".obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  RxString emailError = "".obs;
  RxString passwordError = "".obs;
  TextEditingController emailController = TextEditingController();

  String cpf = "";

  RxBool obscurePassword = true.obs;

  void checkName(String? text) {
    if (text != null) {
      if (!RegExp(AppStrings.reName).hasMatch(text)) {
        nameError.value = AppStrings.errorName;
      } else {
        nameError.value = '';
      }
    } else {
      nameError.value = AppStrings.errorName;
    }
  }

  void checkCpf(String? text) {
    if (text != null) {
      String cpfNumbers = text.replaceAll(RegExp(AppStrings.reNotNumber), '');
      if (!cpfNumbers.isCpf) {
        cpfError.value = AppStrings.errorCpf;
      } else {
        cpfError.value = '';

        cpf = cpfNumbers;
      }
    } else {
      cpfError.value = AppStrings.errorCpf;
    }
  }

  void checkBirthday(String? birthday) {
    DateTime parsedBirthday;

    if (birthday != null) {
      if (!RegExp(AppStrings.reDate).hasMatch(birthday)) {
        birthDayError.value = AppStrings.errorBirthday;
      } else {
        parsedBirthday = DateTime.parse(
          birthday.replaceAllMapped(
            RegExp(AppStrings.reDate),
            (Match m) => '${m[3]}-${m[2]}-${m[1]}',
          ),
        );
        DateTime now = DateTime.now();
        DateTime maxDate = now.subtract(const Duration(days: 365 * 18));
        DateTime minDate = now.subtract(const Duration(days: 365 * 118));
        if (parsedBirthday.isAfter(maxDate)) {
          birthDayError.value = AppStrings.errorUnder18;
        } else if (parsedBirthday.isBefore(minDate)) {
          birthDayError.value = AppStrings.errorOver118;
        } else {
          birthDayError.value = '';
        }
      }
    } else {
      birthDayError.value = AppStrings.errorBirthday;
    }
  }

  void checkPhoneNumber(String? text) {
    if (text != null) {
      if (!text.isPhoneNumber) {
        phoneError.value = AppStrings.errorPhone;
      } else {
        phoneError.value = '';
      }
    } else {
      phoneError.value = AppStrings.errorPhone;
    }
  }

  void goToSecondPage() {
    nameError.value = emailError.value = birthDayError.value = phoneError.value = '';

    checkName(nameController.text);
    checkBirthday(birthDayController.text);
    checkPhoneNumber(phoneNumberController.text);
    checkCpf(cpfController.text);

    if (nameError.isEmpty && emailError.isEmpty && birthDayError.isEmpty && phoneError.isEmpty) {
      pageIndex.value = 1;
    }
  }

  void checkEmail(String? text) {
    if (text != null) {
      if (!text.isEmail) {
        emailError.value = AppStrings.errorEmail;
      } else {
        emailError.value = '';
      }
    } else {
      emailError.value = AppStrings.errorEmail;
    }
  }

  void checkPasswordError(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        passwordError.value = AppStrings.errorEmptyPassword;
      } else if (text.length < 6) {
        passwordError.value = AppStrings.errorPasswordTooShort;
      } else {
        passwordError.value = '';
      }
    } else {
      passwordError.value = AppStrings.errorEmptyPassword;
    }
  }
}
