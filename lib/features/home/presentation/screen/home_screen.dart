import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int totalProducts = 0;
  int limit = 30;
  int skip = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    context.read<ProductsBloc>().add(FetchProductsEvent(limit: limit, skip: skip));
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // Check if we're already fetching data to avoid multiple calls
      final currentState = context.read<ProductsBloc>().state;
      if (currentState is ProductsLoadingState) return;

      // Check if we have more products to load
      if (context.read<ProductsBloc>().state is ProductsLoadedState) {
        final state = context.read<ProductsBloc>().state as ProductsLoadedState;
        totalProducts = context.read<ProductsBloc>().productRepository.totalProducts;

        if (state.products.length >= totalProducts) {
          ToastNotification.showWarningNotification(context, message: 'No more products');
          return;
        }
      }

      // Increment skip for pagination
      limit += 30;

      // Dispatch event to load more products
      context.read<ProductsBloc>().add(FetchProductsEvent(limit: limit, skip: skip));
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
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductsErrorState) {
              return Center(child: Text("Error: ${state.error}"));
            }
            if (state is ProductsLoadedState) {
              final products = state.products;

              return CustomScrollView(
                shrinkWrap: true,
                controller: scrollController,
                slivers: [
                  HomeSliverAppBar(),
                  HomeBody(products: products),
                  if (state.products.length < totalProducts)
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
              );
            }
            return Center(child: Text("No data"));
          },
        ),
      ),
    );
  }
}
