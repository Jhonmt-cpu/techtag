import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:techtag/app/values/app_colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      "Fazer Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titles,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("oie");
                      },
                      child: const Text(
                        "Criar uma conta",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.purple,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
