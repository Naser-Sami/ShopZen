import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class HomeBody extends StatelessWidget {
  final List<ProductEntity> products;

  const HomeBody({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSize.s20, vertical: TSize.s16),
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
            padding:
                const EdgeInsets.symmetric(horizontal: TSize.s20, vertical: TSize.s16),
            child: TextWidget(
              'Hot Deals',
              style: theme.textTheme.titleLarge,
            ),
          ),
          HomeHotDeals(
            products: products,
          )
        ],
      ),
    );
  }
}
