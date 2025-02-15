import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            HomeSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSize.s20, vertical: TSize.s16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          'Categories',
                          style: theme.textTheme.titleLarge,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: TextWidget(
                            'View All',
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HomeCategories(),
                  TSize.s24.toHeight,
                  HomeCarouselSlider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSize.s20, vertical: TSize.s16),
                    child: TextWidget(
                      'Hot Deals',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  HomeHotDeals()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
