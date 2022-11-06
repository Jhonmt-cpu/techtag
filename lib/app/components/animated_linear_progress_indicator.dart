import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:techtag/app/values/app_colors.dart';

class AnimatedLinearProgressIndicator extends StatelessWidget {
  final bool animate;
  final bool isFinalized;

  const AnimatedLinearProgressIndicator({
    Key? key,
    required this.animate,
    required this.isFinalized,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return animate
        ? LoopAnimationBuilder<double>(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.ease,
            tween: Tween<double>(
              begin: 0,
              end: 1,
            ),
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              color: AppColors.green,
              backgroundColor: AppColors.shape01,
            ),
          )
        : LinearProgressIndicator(
            value: isFinalized ? 1 : 0,
            color: AppColors.green,
            backgroundColor: AppColors.shape01,
          );
  }
}
