import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:techtag/app/components/message_dialog.dart';
import 'package:techtag/app/components/order_model.dart';
import 'package:techtag/app/data/model/user_model.dart';
import 'package:techtag/app/data/repositories/orders_repository.dart';
import 'package:techtag/app/values/boxes.dart';

class OrderDetailsController extends GetxController {
  final _ordersRepository = OrdersRepository();

  late String orderId;
  Box<UserModel> userBox = Hive.box<UserModel>(Boxes.userBox);

  final Rxn<OrderModel> order = Rxn<OrderModel>();
  final RxBool isLoading = false.obs;

  final RxDouble animationValue = 0.0.obs;

  Socket? socket;

  @override
  void onInit() {
    orderId = Get.arguments;
    getOfferDetails();
    getOfferSocket();
    ever(animationValue, (_) => animate());
    super.onInit();
  }

  @override
  void onClose() {
    socket?.disconnect();
    super.onClose();
  }

  Future<void> animate() async {
    await Future.delayed(const Duration(milliseconds: 30));

    if (order.value!.status != 'Finalizado') {
      if (animationValue.value >= 1) {
        animationValue.value = 0;
      } else {
        animationValue.value += 0.01;
      }
    } else {
      animationValue.value = 1;
    }
  }

  Future<void> getOfferDetails() async {
    try {
      isLoading.value = true;

      await getOffer();
    } catch (e) {
      debugPrint(e.toString());
      Get.dialog(
        const MessageDialog(
          message: "Não foi possível carregar os detalhes do pedido",
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getOffer() async {
    var orderResponse = await _ordersRepository.getOrder(orderId);

    order.value = orderResponse;
    animationValue.value = 0.025;
  }

  void getOfferSocket() {
    socket = _ordersRepository.getOrderStream();

    socket?.connect();

    socket?.on('connect', (data) {
      socket?.emit(
        'status_about_order',
        jsonEncode({
          'orderId': orderId,
          'userId': userBox.get(0)!.id,
        }),
      );

      socket?.on('status_about_order', (data) {
        if (data == null) {
          return;
        }

        if (data is! Map) {
          return;
        }

        if (data['status'] != null) {
          order.update((val) {
            if (val != null) {
              val.status = data['status'];
            }
          });
        }
      });
    });
  }

  double calcTotal() {
    double total = 0;

    if (order.value != null) {
      for (var element in order.value!.products) {
        total += (element.quantity * double.parse(element.value));
      }
    }

    return total;
  }

  String calcHour() {
    var date = order.value!.createdAt.toLocal().add(const Duration(minutes: 45));

    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}
