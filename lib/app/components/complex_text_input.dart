import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:techtag/app/values/app_colors.dart';
import 'package:techtag/app/values/app_strings.dart';

class ComplexTextInput extends StatefulWidget {
  final String labelText;
  final String? errorText;
  final int? maxLength;
  final Color borderColor;
  final bool roundBordersTop;
  final bool roundBordersBottom;
  final bool enabled;
  final bool readOnly;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool? obscureButtonValue;
  final TextInputAction? textInputAction;
  final TextEditingController? textEditingController;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  FocusNode? focusNode;
  final Function? onChanged;
  final Function? onSubmitted;
  final Function? onTapObscureButton;
  final Color backgroundColor;

  ComplexTextInput({
    Key? key,
    this.enabled = true,
    this.readOnly = false,
    required this.labelText,
    this.errorText = "",
    this.obscureButtonValue,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.obscureText = false,
    this.textInputAction,
    this.textEditingController,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.maxLength,
    this.onTapObscureButton,
    this.borderColor = AppColors.purple,
    this.roundBordersTop = false,
    this.roundBordersBottom = false,
    this.backgroundColor = AppColors.titlesTextPurple,
  })  : assert(obscureButtonValue != null ? onTapObscureButton != null : true),
        super(key: key);

  @override
  State<ComplexTextInput> createState() => _ComplexTextInputState();
}

class _ComplexTextInputState extends State<ComplexTextInput> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    widget.focusNode ??= FocusNode();

    widget.focusNode?.addListener(
      () {
        if (widget.focusNode?.hasFocus ?? false) {
          widget.focusNode?.requestFocus();
        }

        setState(() {
          isFocused = widget.focusNode?.hasFocus ?? false;
        });
      },
    );

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.roundBordersTop ? 8 : 0),
          topRight: Radius.circular(widget.roundBordersTop ? 8 : 0),
          bottomLeft: Radius.circular(widget.roundBordersBottom ? 8 : 0),
          bottomRight: Radius.circular(widget.roundBordersBottom ? 8 : 0),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.linesInWhite,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isFocused ? AppColors.purple : AppColors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 2,
            height: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 15,
                left: 24,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.labelText,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.inputs,
                      height: 20 / 10,
                    ),
                  ),
                  TextField(
                    cursorColor: AppColors.base,
                    onSubmitted: widget.onSubmitted as void Function(String)?,
                    focusNode: widget.focusNode,
                    autofocus: widget.autofocus,
                    controller: widget.textEditingController,
                    textInputAction: widget.textInputAction,
                    enabled: widget.enabled,
                    readOnly: widget.readOnly,
                    textCapitalization: widget.textCapitalization,
                    obscureText: widget.obscureButtonValue ?? false,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.all(0),
                      isDense: true,
                      border: InputBorder.none,
                      counterText: "",
                    ),
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    maxLength: widget.maxLength,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onChanged: widget.onChanged as void Function(String)?,
                    style: const TextStyle(
                      color: AppColors.base,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 24 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _obscureButton(),
        ],
      ),
    );
  }

  Widget _obscureButton() {
    if (widget.obscureButtonValue == null) {
      return const SizedBox();
    }

    String assetName = widget.obscureButtonValue!
        ? 'assets/icons/showPassword.svg'
        : 'assets/icons/hidePassword.svg';

    return GestureDetector(
      onTap: () {
        widget.enabled ? widget.onTapObscureButton!() : () {};
      },
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        child: SvgPicture.asset(
          assetName,
          color: !widget.enabled ? AppColors.inputs : null,
        ),
      ),
    );
  }
}

class MobilePhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex = newValue.selection.end;
    int oldLength = newValue.text.length;
    String formatted = '';
    String original = newValue.text;

    String numbersOnly = original.replaceAll(RegExp(AppStrings.reNotNumber), '');
    if (numbersOnly.length > 11) {
      numbersOnly = numbersOnly.substring(0, 11);
    }
    int length = min(numbersOnly.length, 11);

    for (int k = 0; k < length; k++) {
      if (k == 0) {
        formatted += '(';
      }
      if (k == 2) {
        formatted += ')';
      }
      if (k == 7) {
        formatted += '-';
      }
      formatted += numbersOnly[k];
    }

    int delta = formatted.length - oldLength;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex + delta),
    );
  }
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex = newValue.selection.end;
    int oldLength = newValue.text.length;
    String formatted = '';
    String original = newValue.text;

    String numbersOnly = original.replaceAll(RegExp(AppStrings.reNotNumber), '');
    if (numbersOnly.length > 11) {
      numbersOnly = numbersOnly.substring(0, 11);
    }
    int length = min(numbersOnly.length, 11);

    for (int k = 0; k < length; k++) {
      if (k == 3) {
        formatted += '.';
      }
      if (k == 6) {
        formatted += '.';
      }
      if (k == 9) {
        formatted += '-';
      }
      formatted += numbersOnly[k];
    }

    int delta = formatted.length - oldLength;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex + delta),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  bool updating = false;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex = newValue.selection.end;
    int oldLength = newValue.text.length;
    String formatted = '';
    String original = newValue.text;

    String numbersOnly = original.replaceAll(RegExp(AppStrings.reNotNumber), '');
    if (numbersOnly.length > 8) {
      numbersOnly = numbersOnly.substring(0, 8);
    }
    int length = min(numbersOnly.length, 8);

    for (int k = 0; k < length; k++) {
      if (k == 2) {
        formatted += '/';
      }
      if (k == 4) {
        formatted += '/';
      }
      formatted += numbersOnly[k];
    }

    int delta = formatted.length - oldLength;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex + delta),
    );
  }
}
