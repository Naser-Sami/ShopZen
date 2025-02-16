import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/features/home/_home.dart';

class HomeHotDeals extends StatelessWidget {
  const HomeHotDeals({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
      child: ProductsListViewWidget(
        products: products,
      ),
    );
  }
}
