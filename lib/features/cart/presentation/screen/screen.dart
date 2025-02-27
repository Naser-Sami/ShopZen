import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Cart'),
        actions: const [
          NotificationsIconWidget(),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconWidget(
              name: 'shopping-cart',
              width: TSize.s64,
              height: TSize.s64,
            ),
            TSize.s16.toHeight,
            TextWidget(
              "Your Cart is Empty!",
              style: textTheme.titleLarge,
            ),
            TSize.s12.toHeight,
            TextWidget(
              "When you add product, they will appear here.",
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
