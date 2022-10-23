import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techtag/app/values/app_colors.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final Uint8List icon;

  const CategoryButton({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(73),
            color: AppColors.littlePurple,
          ),
          height: 60,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: SvgPicture.memory(
              icon,
              color: AppColors.baseTitlePurple,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.shape01,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
