import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
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
                '20',
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
              // Discount = 100 × (Original price - Discounted price) / Original price .
              Text(
                (100 * (cart.total! - cart.total! * 0.20) / cart.total!).toStringAsFixed(2),
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: TSize.s12),
          DottedLine(
            dashColor: theme.colorScheme.onSurface,
          ),
          const SizedBox(height: TSize.s12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: theme.textTheme.bodyLarge,
              ),
              Text(
                (cart.total! - ((cart.total! * 10) / 100)).toStringAsFixed(2),
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
