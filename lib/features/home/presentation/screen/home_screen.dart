import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/features/_features.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  List<ProductEntity> products = [];
  int limit = 10;
  int skip = 0;
  int totalProducts = 0;
  bool isLoadingMoreData = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);

    _getProducts();
  }

  Future<List<ProductEntity>> _getProducts(
      {int limit = 10, int skip = 0, String? select}) async {
    products = await sl<IProductRepository>()
        .getAllProducts(limit: limit, skip: skip, select: select);
    setState(() {});
    totalProducts = sl<IProductRepository>().totalProducts;

    return products;
  }

  Future<void> _scrollListener() async {
    if (isLoadingMoreData) return;
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (products.length == totalProducts) {
        ToastNotification.showWarningNotification(context, message: 'No more products');

        return;
      }
      setState(() => isLoadingMoreData = true);
      products = await _getProducts(limit: limit += 10, skip: 0);

      setState(() => isLoadingMoreData = false);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          controller: scrollController,
          slivers: [
            HomeSliverAppBar(),
            HomeBody(products: products),
            if (isLoadingMoreData)
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
