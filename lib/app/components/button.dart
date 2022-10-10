import 'package:flutter/material.dart';
import 'package:techtag/app/values/app_colors.dart';

class Button extends StatelessWidget {
  final bool enable;
  final String text;
  final Function() onTap;
  final Color backgroundColor;

  const Button({
    Key? key,
    required this.enable,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: enable ? backgroundColor : AppColors.disable,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: enable ? AppColors.titlesTextPurple : AppColors.complements,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
