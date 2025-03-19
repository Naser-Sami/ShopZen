import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

import '/core/_core.dart';
import '/features/_features.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int totalProducts = 0;
  int limit = 30;
  int skip = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Check if we're already fetching data to avoid multiple calls
      final currentState = context.read<ProductsBloc>().state;
      if (currentState is ProductsLoadingState) return;

      // Check if we have more products to load
      if (context.read<ProductsBloc>().state is ProductsLoadedState) {
        final state = context.read<ProductsBloc>().state as ProductsLoadedState;
        totalProducts =
            context.read<ProductsBloc>().productRepository.totalProducts;

        if (state.products.length >= totalProducts) {
          ToastNotification.showWarningNotification(context,
              message: 'No more products');
          return;
        }
      }

      // Increment skip for pagination
      limit += 30;

      // Dispatch event to load more products
      context
          .read<ProductsBloc>()
          .add(FetchProductsEvent(limit: limit, skip: skip));
    }
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    _scrollController.animateTo(
      event.to,
      duration: event.duration,
      curve: event.curve,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollsToTop(
          onScrollsToTop: _onScrollsToTop,
          child: CustomScrollView(
            shrinkWrap: true,
            controller: _scrollController,
            slivers: const [
              HomeSliverAppBar(),
              HomeBody(),
            ],
          ),
        ),
      ),
    );
  }
}
