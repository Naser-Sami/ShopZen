import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/features/_features.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final product = products[index];

          return ListTile(
            onTap: () {
              context.push(
                '${SearchScreen.routeName}/${ProductDetailsScreen.routeName}/$index',
                extra: product,
              );
            },
            title: TextWidget(
              product.title.toString(),
              style: theme.textTheme.bodyLarge,
            ),
            subtitle: TextWidget(
              product.description.toString(),
              style: theme.textTheme.bodySmall,
              maxLines: 2,
            ),
            leading: product.images.isNotEmpty
                ? Image.network(
                    product.images.first.toString(),
                    width: 50,
                    height: 50,
                  )
                : null,
          );
        },
      ),
    );
  }
}
