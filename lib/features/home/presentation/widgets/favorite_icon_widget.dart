import 'package:flutter/material.dart';
import '/config/_config.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: TSize.s24,
      height: TSize.s24,
      decoration: BoxDecoration(
        color: LightThemeColors.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(TRadius.r04),
      ),
      child: IconButton(
        onPressed: () {},
        iconSize: 16,
        padding: EdgeInsets.zero,
        icon: Center(
          child: Icon(
            Icons.favorite_border_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
