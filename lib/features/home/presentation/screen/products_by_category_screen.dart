import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_zen/config/_config.dart';
import 'package:shop_zen/core/_core.dart';
import '/features/_features.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  static const routeName = 'products-by-category';
  const ProductsByCategoryScreen({super.key, required this.category});

  final String category;

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  @override
  void initState() {
    super.initState();

    context
        .read<ProductsBloc>()
        .add(GetProductsByCategoryEvent(category: widget.category));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products by ${widget.category.toCapitalized}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            switch (state) {
              case ProductsLoadingState():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ProductsLoadedState():
                final products = state.productsByCategory;
                return ProductsListViewWidget(
                  products: products,
                  physics: const BouncingScrollPhysics(),
                );
              case ProductsErrorState():
                return Center(
                  child: Text('Error: ${state.error}'),
                );

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
