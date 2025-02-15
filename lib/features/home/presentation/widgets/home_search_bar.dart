import 'package:flutter/material.dart';

import '/config/_config.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: TSize.s48,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TRadius.r08),
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.30),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormFieldComponent(
        hintText: 'Find your favorite items',
        enabledBorder: InputBorder.none,
        prefixIcon: IconButton(
          onPressed: null,
          icon: IconWidget(
            name: 'search',
            width: TSize.s20,
            height: TSize.s20,
            color: theme.colorScheme.onSurface,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: IconWidget(
            name: 'search-visual',
            width: TSize.s20,
            height: TSize.s20,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
