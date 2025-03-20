import 'package:flutter/material.dart';
import 'package:shop_zen/core/_core.dart';
import '/config/_config.dart';

class SocialMediaAuthenticationWidget extends StatelessWidget {
  const SocialMediaAuthenticationWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  final String icon;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TRadius.r08),
      ),
      child: Container(
        height: TSize.s50,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: TPadding.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TRadius.r08),
          border: Border.all(
            color: theme.colorScheme.primaryContainer,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 211,
              child: Row(
                children: [
                  IconWidget(
                    name: icon,
                    width: 22,
                    height: 22,
                    color: TFunctions.isDarkMode(context) ? Colors.grey : null,
                  ),
                  const SizedBox(width: TSize.s16),
                  TextWidget(
                    text,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
