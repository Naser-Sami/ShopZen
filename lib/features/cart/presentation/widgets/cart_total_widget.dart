import 'package:flutter/material.dart';

import '/features/cart/_cart.dart';
import '/config/_config.dart';

class CartTotalWidget extends StatelessWidget {
  const CartTotalWidget({super.key, required this.cart});

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub-total',
                style: theme.textTheme.bodyLarge,
              ),
              Text(
                '${cart.total}',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: TSize.s12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Fee',
                style: theme.textTheme.bodyLarge,
              ),
              Text(
                '${cart.total}',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: TSize.s12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: theme.textTheme.bodyLarge,
              ),
              Text(
                '${cart.total}',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: TSize.s12),
        ],
      ),
    );
  }
}
