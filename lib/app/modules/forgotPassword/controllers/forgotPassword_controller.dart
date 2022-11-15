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

class ForgotPasswordController extends GetxController {
  Box<UserModel> userBox = Hive.box<UserModel>(Boxes.userBox);


  RxString emailError = "".obs;
  TextEditingController emailController = TextEditingController();

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

  

  Future<void> forgot() async {
    emailError.value = '';

    checkEmail(emailController.text);


    if (emailError.value == "" ) {
      try {
        isLoading.value = true;

        var user = await _usersRepository.forgot(
          email: emailController.text,
        );

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
              message: "Email enviado com sucesso!",
            ),
          );
        }
      } catch (e) {
        Get.dialog(
          const MessageDialog(
            message: "Opps, Algo deu errado na recuperação de email!",
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}