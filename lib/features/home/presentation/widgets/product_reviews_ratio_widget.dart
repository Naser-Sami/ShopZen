import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/utils/_utils.dart';
import '/features/home/_home.dart';

class ProductReviewsRatioWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductReviewsRatioWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconWidget(name: 'star'),
        TSize.s08.toWidth,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: product.rating.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " (${product.stock})",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
