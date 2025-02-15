import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class TextFormFieldComponent extends StatelessWidget {
  const TextFormFieldComponent({
    super.key,
    required this.hintText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.textFieldWithTitle = false,
    this.title,
    this.controller,
    this.validator,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.onChanged,
    this.successColor,
    this.enabledBorder,
  });

  // Variables
  final String hintText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool textFieldWithTitle;
  final String? title;
  final String obscuringCharacter;
  final bool obscureText;
  final Color? successColor;
  final InputBorder? enabledBorder;

  // Controllers
  final TextEditingController? controller;

  // Functions
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (textFieldWithTitle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TSize.s04.toHeight,
          _textField(context),
        ],
      );
    } else {
      return _textField(context);
    }
  }

  Widget _textField(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      decoration: InputDecoration(
        hintText: hintText,
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixIcon: prefixIcon,
        hintStyle: theme.textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TSize.s10),
        ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(TSize.s10),
              borderSide: BorderSide(
                color: successColor ?? theme.primaryColor,
              ),
            ),
        focusedBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(TSize.s10),
              borderSide: BorderSide(
                color: successColor ?? theme.primaryColor,
              ),
            ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TSize.s10),
          borderSide: BorderSide(
            color: TFunctions.isDarkMode(context)
                ? DarkThemeColors.outline
                : LightThemeColors.outline,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TSize.s10),
          borderSide: BorderSide(
            color: TFunctions.isDarkMode(context)
                ? DarkThemeColors.error
                : LightThemeColors.error,
          ),
        ),
      ),
    );
  }
}
