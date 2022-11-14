import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:techtag/app/components/animated_linear_progress_indicator.dart';
import 'package:techtag/app/values/app_colors.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.purple,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Obx(() {
                if (controller.order.value == null) {
                  return const SizedBox(
                    height: 80,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.green,
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Previsão de retirada',
                      style: TextStyle(
                        color: AppColors.shape01,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      controller.calcHour(),
                      style: const TextStyle(
                        color: AppColors.shape01,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: const AnimatedLinearProgressIndicator(
                              animate: false,
                              isFinalized: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Obx(
                              () => AnimatedLinearProgressIndicator(
                                animate: controller.order.value!.status == 'Pagamento aprovado',
                                isFinalized: controller.order.value!.status != 'Pagamento Aprovado',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Obx(
                              () => AnimatedLinearProgressIndicator(
                                animate: controller.order.value!.status == 'Aguardando Retirada',
                                isFinalized: controller.order.value!.status == 'Finalizado',
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 2,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(5),
                        //     child: Obx(
                        //       () => LinearProgressIndicator(
                        //         value: controller.order.value!.status != 'Aguardando Retirada'
                        //             ? controller.animationValue.value
                        //             : 1,
                        //         backgroundColor: AppColors.shape01,
                        //         valueColor: const AlwaysStoppedAnimation<Color>(
                        //           AppColors.green,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        // Expanded(
                        //   flex: 1,
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(5),
                        //     child: Obx(
                        //       () => LinearProgressIndicator(
                        //         value: controller.order.value!.status == 'Aguardando Retirada'
                        //             ? controller.animationValue.value
                        //             : controller.order.value!.status == 'Finalizado'
                        //                 ? 1
                        //                 : 0,
                        //         backgroundColor: AppColors.shape01,
                        //         valueColor: const AlwaysStoppedAnimation<Color>(
                        //           AppColors.green,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.green,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          controller.order.value!.status,
                          style: const TextStyle(
                            color: AppColors.shape01,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  const Text(
                    'Detalhes do pedido',
                    style: TextStyle(
                      color: AppColors.titles,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    if (controller.order.value == null) {
                      return const SizedBox(
                        height: 350,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.purple,
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.order.value!.products.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.shape01,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(5),
                                //   child: Image.memory(
                                //       controller.order.value!.products[index].),
                                // ),
                                const SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width - 48,
                                      ),
                                      child: Text(
                                        controller.order.value!.products[index].name,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColors.purple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Quantidade: ${controller.order.value!.products[index].quantity}",
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColors.darkPurple,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 30),
                  Obx(() {
                    if (controller.order.value == null) {
                      return const SizedBox();
                    }

                    return Row(
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
                          "R\$${controller.calcTotal()}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.titles,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
