import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/icons/background.svg",
            height: Get.height,
            width: Get.width,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                AppStrings.techTag,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titlesTextPurple,
                ),
              ),
              SizedBox(
                width: Get.width,
              )
            ],
          ),
        ],
      ),
    );
  }
}
