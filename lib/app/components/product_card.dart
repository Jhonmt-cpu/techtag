import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techtag/app/values/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String name;
  final Uint8List image;
  final double value;
  final Function() addToKart;

  const ProductCard({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.value,
    required this.addToKart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.titlesTextPurple,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.green.withOpacity(0.15),
              spreadRadius: 0.1,
              blurRadius: 10,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  image,
                  height: 70,
                ),
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.purple,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            Row(
              children: [
                Text(
                  "1Un, R\$$value",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.darkPurple,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
                const Expanded(child: SizedBox()),
                InkWell(
                  onTap: addToKart,
                  child: Container(
                    height: 30,
                    width: 30,
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
            )
          ],
        ),
      ),
    );
  }
}
