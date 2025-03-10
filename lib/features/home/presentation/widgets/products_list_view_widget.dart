import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '/config/_config.dart';
import '/core/utils/_utils.dart';
import '/features/home/_home.dart';

class ProductsListViewWidget extends StatefulWidget {
  final List<ProductEntity> products;
  final ScrollPhysics? physics;
  const ProductsListViewWidget({super.key, required this.products, this.physics});

  @override
  State<ProductsListViewWidget> createState() => _ProductsListViewWidgetState();
}

class _ProductsListViewWidgetState extends State<ProductsListViewWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: widget.physics ?? const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: size.width / 2, // Approximate width per card
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.60, // Adjust as needed based on content
        ),
        padding: EdgeInsets.zero,
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 600),
            child: SlideAnimation(
              verticalOffset: 250.0,
              child: FadeInAnimation(
                child: MaterialButton(
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
                                      image: NetworkImage(product.thumbnail),
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
                                const SizedBox(height: TSize.s16),
                                TextWidget(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                TSize.s08.toHeight,
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "\$${(product.price * ((1 - product.discountPercentage / 100))).toStringAsFixed(2)}",
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "\$${product.price.toStringAsFixed(2)}",
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
