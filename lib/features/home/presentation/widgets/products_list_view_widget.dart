import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart';
import '/core/utils/_utils.dart';
import '/features/home/_home.dart';

class ProductsListViewWidget extends StatefulWidget {
  final List<ProductEntity> products;
  const ProductsListViewWidget({super.key, required this.products});

  @override
  State<ProductsListViewWidget> createState() => _ProductsListViewWidgetState();
}

class _ProductsListViewWidgetState extends State<ProductsListViewWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: size.width / 2, // Approximate width per card
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.64, // Adjust as needed based on content
      ),
      padding: EdgeInsets.zero,
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];

        return MaterialButton(
          onPressed: () {
            context.push(
              '${HomeScreen.routeName}/${ProductDetailsScreen.routeName}/$index',
              extra: product,
            );
          },
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TRadius.r08),
          ),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Dynamic height
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Hero(
                        tag: "Product${product.id}",
                        child: Container(
                          height: size.height * 0.16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(TRadius.r08),
                            image: DecorationImage(
                              image: NetworkImage(product.thumbnail ?? ""),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        top: TSize.s08,
                        end: TSize.s08,
                        child: FavoriteIconWidget(product: product),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TPadding.p16)
                        .copyWith(bottom: TPadding.p08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min, // Dynamic height
                      children: [
                        SizedBox(height: TSize.s16),
                        TextWidget(
                          product.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TSize.s08.toHeight,
                        RichText(
                          text: TextSpan(
                            children: [
                              if (product.price != null)
                                TextSpan(
                                  text:
                                      "\$${(product.price! * (product.discountPercentage != null ? (1 - product.discountPercentage! / 100) : 1)).toStringAsFixed(2)}",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              TextSpan(
                                text: "\$${product.price?.toStringAsFixed(2)}",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TSize.s08.toHeight,
                        ProductReviewsRatioWidget(product: product),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
