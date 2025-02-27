import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    UserModel? user = context.watch<UserCubit>().state;

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
            "Welcome, ${user?.name ?? ''}",
            style: theme.textTheme.bodyLarge,
          ),
          TextWidget(
            user?.address ?? '',
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
      actions: const [
        NotificationsIconWidget(),
      ],
      bottom: homeAppBar(context),
    );
  }
}

PreferredSizeWidget? homeAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: false,
    toolbarHeight: 80,
    title: SearchBarWidget(
      onTap: () => context.push(SearchScreen.routeName),
    ),
  );
}
