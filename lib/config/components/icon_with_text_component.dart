import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class IconWithTextComponent extends StatelessWidget {
  final String icon;
  final String title;
  const IconWithTextComponent({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: TSize.s24,
            height: TSize.s24,
            child: IconWidget(
              name: icon,
              color: TFunctions.isDarkMode(context)
                  ? DarkThemeColors.onSurface
                  : LightThemeColors.onSurface,
            ),
          ),
          TSize.s06.toWidth,
          Flexible(
            fit: FlexFit.tight,
            child: TextWidget(
              title.toTitleCase,
              style: context.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
