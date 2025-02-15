import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/home/_home.dart';

class HomeHotDeals extends StatefulWidget {
  const HomeHotDeals({super.key});

  @override
  State<HomeHotDeals> createState() => _HomeHotDealsState();
}

class _HomeHotDealsState extends State<HomeHotDeals> {
  List<ProductEntity> products = [];

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  Future<void> _getProducts() async {
    products = await sl<IProductRepository>().getAllProducts();
    setState(() {});
  }

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
