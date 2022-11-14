import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:techtag/app/components/category_button.dart';
import 'package:techtag/app/components/product_card.dart';
import 'package:techtag/app/values/app_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          backgroundColor: AppColors.purple,
          elevation: 0,
          titleSpacing: 0,
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            color: AppColors.purple,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    bottom: 32,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          48,
                        ),
                        child: Image.network(
                          "https://media-exp1.licdn.com/dms/image/C4E03AQFQCBUghaqGvg/profile-displayphoto-shrink_400_400/0/1654804808170?e=1671667200&v=beta&t=V_lESzO0j362YaUvPPKfY7KDHSn16-3ON02OVslNOFw",
                          height: 48,
                          width: 48,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Text(
                        "João Mateus",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.titlesTextPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () => controller.goToCart(),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.littlePurple,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/marketCart.svg",
                              color: AppColors.baseTitlePurple,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CarouselSlider.builder(
                  itemCount: 5,
                  options: CarouselOptions(
                    height: 158,
                    autoPlay: true,
                    autoPlayInterval: const Duration(
                      seconds: 4,
                    ),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      color: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://img.freepik.com/vetores-premium/modelo-de-farmacia-de-banner-medica-vetorial-para-hospitais-farmacias-de-publicidade-treinamento-internacional_497982-272.jpg?w=2000",
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 24,
                    left: 24,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Categorias 💊",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.shape01,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 12,
                  ),
                  child: SizedBox(
                    height: 100,
                    child: Obx(
                      () => ListView.separated(
                        padding: const EdgeInsets.only(left: 24),
                        itemCount: controller.categoriesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryButton(
                            label: controller.categoriesList[index].name,
                            icon: controller.categoriesList[index].icon,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 16,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              left: 24,
              right: 24,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Líderes de venda 🔥",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.base,
                    fontWeight: FontWeight.w600,
                    height: 30 / 20,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Obx(
                  () => GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: controller.productsList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        id: controller.productsList[index].id,
                        name: controller.productsList[index].name,
                        image: controller.productsList[index].image,
                        value: controller.productsList[index].value,
                        addToKart: () => controller.addProduct(controller.productsList[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
