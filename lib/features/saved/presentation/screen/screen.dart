import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/features/_features.dart';

class SavedItemsScreen extends StatelessWidget {
  static const routeName = '/saved';
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Saved Items'),
        actions: const [
          NotificationsIconWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            log('STATE ${state.runtimeType}');

            switch (state) {
              case ProductsLoadingState():
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ProductsLoadedState():
                final favoriteProducts =
                    state.products.where((p) => p.isFavorite).toList();

                if (favoriteProducts.isEmpty) {
                  return const EmptySavedItemsWidget();
                }

                return ProductsListViewWidget(
                  products: favoriteProducts,
                  physics: const BouncingScrollPhysics(),
                );

              case ProductsErrorState():
                return const Center(
                  child: Text('Error loading products'),
                );
              default:
                return const EmptySavedItemsWidget();
            }
          },
        ),
      ),
    );
  }
}
