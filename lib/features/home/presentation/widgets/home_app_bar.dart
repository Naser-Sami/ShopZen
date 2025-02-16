import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/features/_features.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      toolbarHeight: TSize.s100,
      collapsedHeight: TSize.s100,
      expandedHeight: TSize.s100,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'Location',
            style: theme.textTheme.bodyLarge,
          ),
          TextWidget(
            'Amman, Jordan',
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // only for test sing out
            // sl<IFirebaseAuthService>().signOut().then((value) {
            //   if (context.mounted) {
            //     context.go(OnboardingScreen.routeName);
            //   }
            // });
          },
          icon: IconWidget(
            name: 'notification',
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
      bottom: homeAppBar(context),
    );
  }
}

PreferredSizeWidget? homeAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: false,
    title: HomeSearchBar(),
  );
}
