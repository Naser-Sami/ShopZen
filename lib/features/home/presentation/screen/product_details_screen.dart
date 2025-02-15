import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/features/home/_home.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  const ProductDetailsScreen({super.key, required this.image, required this.index});

  // Add the entity here
  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              Padding(
                padding: const EdgeInsetsDirectional.only(end: TSize.s16),
                child: FavoriteIconWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
