import 'package:flutter/material.dart';

import '/config/_config.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetailsScreen({super.key, required this.image, required this.index});

  // Add the entity here
  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 400,
            automaticallyImplyLeading: false,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.10),
            title: TextWidget(
              'Product Details',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "HotDeal$index",
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              Container(
                width: TSize.s24,
                height: TSize.s24,
                margin: const EdgeInsetsDirectional.only(end: TPadding.p16),
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
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
