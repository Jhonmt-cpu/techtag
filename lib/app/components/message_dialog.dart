import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtag/app/components/button.dart';

import 'package:techtag/app/values/app_colors.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? footer;
  final String button1Label;
  final String? button2Label;
  final Function? button1Function;
  final Function? button2Function;
  final bool button1SkipDefault;
  final bool button2SkipDefault;
  final bool showButtons;

  const MessageDialog({
    Key? key,
    this.title = 'Alerta!',
    required this.message,
    this.footer,
    this.button1Label = 'Ok',
    this.button2Label,
    this.button1Function,
    this.button2Function,
    this.button1SkipDefault = false,
    this.button2SkipDefault = false,
    this.showButtons = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 16,
          ),
          child: Container(
            width: !GetPlatform.isMobile ? 350 : null,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.base,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.base,
                      height: 1.714,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buttonRows(context),
                  if (footer != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      footer!,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 15 / 11,
                        color: AppColors.base,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ]),
          ),
        ),
      ),
    );
  }

  _buttonRows(BuildContext context) {
    List<Widget> widgets = [];
    if (button2Label != null && button2Label!.isNotEmpty) {
      widgets.add(Expanded(
        child: Button(
          backgroundColor: AppColors.green,
          enable: true,
          text: button2Label ?? "",
          onTap: () {
            if (!button2SkipDefault) {
              Get.back();
            }
            if (button2Function is Function) {
              button2Function!();
            }
          },
        ),
      ));
      widgets.add(const SizedBox(width: 15));
    }
    if (showButtons) {
      widgets.add(Expanded(
        child: Button(
            backgroundColor: AppColors.purple,
            enable: true,
            text: button1Label,
            onTap: () {
              if (!button1SkipDefault) {
                Get.back();
              }
              if (button1Function is Function) {
                button1Function!();
              }
            }),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
