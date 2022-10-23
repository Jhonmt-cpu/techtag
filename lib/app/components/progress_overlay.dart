import 'package:flutter/material.dart';
import 'package:techtag/app/values/app_colors.dart';

class ProgressOverlay extends StatelessWidget {
  const ProgressOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.base.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.purple,
        ),
      ),
    );
  }
}
