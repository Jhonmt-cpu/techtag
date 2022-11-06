import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:techtag/app/components/button.dart';
import 'package:techtag/app/routes/app_pages.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.shape01,
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.cartTitle,
          style: TextStyle(
            color: AppColors.shape01,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.separated(
                itemCount: controller.products.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image.memory(
                          controller.products[index].image,
                          height: 88,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                controller.products[index].name,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "1Un, R\$${controller.products[index].value}",
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.darkPurple,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => controller.removeProductQuantity(index),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              color: AppColors.titles,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                "assets/icons/minus.svg",
                                color: AppColors.shape01,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "${controller.products[index].cartQuantity}",
                          style: const TextStyle(
                            color: AppColors.littlePurple,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () => controller.addProductQuantity(index),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              color: AppColors.green,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                "assets/icons/plus.svg",
                                color: AppColors.shape01,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return Container(
                    width: Get.width,
                    height: 1,
                    color: AppColors.shape01,
                  );
                }),
              ),
            ),
          ),
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
            child: Obx(() {
              return Column(
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
                      Text(
                        "R\$${controller.total.value}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.titles,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Button(
                    enable: controller.total.value > 0,
                    text: "Fechar Compra",
                    onTap: () {
                      Get.toNamed(Routes.PAYMENT_METHOD);
                    },
                    backgroundColor: AppColors.green,
                  ),
                ],
              );
            }),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
