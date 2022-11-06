import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:techtag/app/components/button.dart';
import 'package:techtag/app/components/credit_card.dart';
import 'package:techtag/app/components/progress_overlay.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

import '../controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.purple,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              AppStrings.paymentMethodTitle,
              style: TextStyle(
                color: AppColors.shape01,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Cartões",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.titles,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.openAddNewCardBottomSheet(context),
                      child: const Text(
                        "+ Adicionar novo cartão",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.anotherPurple,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: Obx(
                  () => PageView.builder(
                    controller: controller.pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.creditCards.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => AnimatedPadding(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                          padding: EdgeInsets.only(
                            top: index == controller.currentPosition.value ? 0 : 10,
                            bottom: index == controller.currentPosition.value ? 0 : 10,
                            right: 10,
                            left: 10,
                          ),
                          child: CreditCard(
                            cardHolder: controller.creditCards[index].cardHolder,
                            cardNumber: controller.creditCards[index].cardNumber,
                            expirationDate: controller.creditCards[index].expireDate,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 6,
                    child: ListView.separated(
                      itemCount: controller.creditCards.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              color: controller.currentPosition.value == index
                                  ? AppColors.purple
                                  : AppColors.baseTitlePurple,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 6,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                height: 1,
                width: Get.width,
                color: AppColors.base.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 24,
                  right: 24,
                  bottom: 44,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.titles,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            "R\$${controller.total}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.titles,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Button(
                      enable: true,
                      text: "Pagar Agora",
                      onTap: () => controller.requestOrder(),
                      backgroundColor: AppColors.green,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Obx(() => controller.isLoading.value ? const ProgressOverlay() : const SizedBox()),
      ],
    );
  }
}
