import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:techtag/app/components/message_dialog.dart';
import 'package:techtag/app/data/model/user_model.dart';
import 'package:techtag/app/data/repositories/users_repository.dart';
import 'package:techtag/app/routes/app_pages.dart';
import 'package:techtag/app/values/app_strings.dart';
import 'package:techtag/app/values/boxes.dart';

class LoginController extends GetxController {
  Box<UserModel> userBox = Hive.box<UserModel>(Boxes.userBox);

  RxBool obscurePassword = true.obs;

  RxString emailError = "".obs;
  RxString passwordError = "".obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  final _usersRepository = UsersRepository();

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
      } else if (text.length < 3) {
        passwordError.value = AppStrings.errorPasswordTooShort;
      } else {
        passwordError.value = '';
      }
    } else {
      passwordError.value = AppStrings.errorEmptyPassword;
    }
  }

  Future<void> login() async {
    emailError.value = passwordError.value = '';

    checkEmail(emailController.text);
    checkPasswordError(passwordController.text);

    if (emailError.value == "" && passwordError.value == "") {
      try {
        isLoading.value = true;

        var user = await _usersRepository.login(
          email: emailController.text,
          password: passwordController.text,
        );

        await userBox.add(user);

        Get.offAllNamed(Routes.HOME);
      } on DioError catch (error) {
        String? message = error.response?.data["message"];

        if (message != null) {
          Get.dialog(
            MessageDialog(
              message: message,
            ),
          );
        } else {
          Get.dialog(
            const MessageDialog(
              message: "Opps, Algo deu errado no seu Login!",
            ),
          );
        }
      } catch (e) {
        Get.dialog(
          const MessageDialog(
            message: "Opps, Algo deu errado no seu cadastro!",
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
