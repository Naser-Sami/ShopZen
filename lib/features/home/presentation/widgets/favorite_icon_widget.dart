import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/_home.dart';
import '/config/_config.dart';

class FavoriteIconWidget extends StatelessWidget {
  final ProductEntity product;

  const FavoriteIconWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: TSize.s24,
      height: TSize.s24,
      decoration: BoxDecoration(
        color: LightThemeColors.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(TRadius.r04),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              // Get the updated list of products
              if (state is ProductsLoadedState) {
                final updatedProduct =
                    state.products.firstWhere((prod) => prod.id == product.id);

                return IconButton(
                  onPressed: () {
                    context
                        .read<ProductsBloc>()
                        .add(ToggleFavoriteEvent(product: updatedProduct));
                  },
                  iconSize: 16,
                  padding: EdgeInsets.zero,
                  icon: Center(
                    child: Icon(
                      updatedProduct.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: updatedProduct.isFavorite ? Colors.red : Colors.black,
                    ),
                  ),
                );
              } else {
                return Container(); // or some default widget if no data
              }
            },
          );
        },
      ),
    );
  }
}
