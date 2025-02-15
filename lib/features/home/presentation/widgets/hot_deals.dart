import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/features/home/_home.dart';

class HomeHotDeals extends StatefulWidget {
  const HomeHotDeals({super.key});

  @override
  State<HomeHotDeals> createState() => _HomeHotDealsState();
}

class _HomeHotDealsState extends State<HomeHotDeals> {
  List<ProductEntity> products = [
    ProductEntity(
      id: 1,
      title: 'iPhone 9',
      description: 'An apple mobile which is nothing like apple',
      price: 549,
      discountPercentage: 12.96,
      rating: 4.69,
      stock: 94,
      brand: 'Apple',
      category: 'smartphones',
      thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      images: [
        'https://i.dummyjson.com/data/products/1/1.jpg',
        'https://i.dummyjson.com/data/products/1/2.jpg',
        'https://i.dummyjson.com/data/products/1/3.jpg',
        'https://i.dummyjson.com/data/products/1/4.jpg',
        'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
      ],
    ),
  ];

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
