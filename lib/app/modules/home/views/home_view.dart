import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.increment();
      }),
      body: Center(
        child: Obx(() => Text(
              'HomeView is working with counter ${controller.count}',
              style: const TextStyle(fontSize: 20),
            )),
      ),
    );
  }
}
