import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/config/_config.dart';
import '/core/utils/_utils.dart';
import '/features/home/_home.dart';

class ProductsListViewWidget extends StatelessWidget {
  final List<ProductEntity> products;
  const ProductsListViewWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverWovenGridDelegate.extent(
        pattern: [
          WovenGridTile(
            0.65,
            crossAxisRatio: 1,
            alignment: AlignmentDirectional.centerStart,
          ),
          WovenGridTile(
            0.69,
            crossAxisRatio: 1,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
        maxCrossAxisExtent: 200,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return MaterialButton(
          onPressed: () {
            GoRouter.of(context).push(
              '${ProductDetailsScreen.routeName}/$index',
              extra: product,
            );
          },
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TRadius.r08),
          ),
          child: Card(
            child: Column(
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: "Product${product.id}",
                      child: Container(
                        height: size.height * 0.16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TRadius.r08),
                          image: DecorationImage(
                            image: NetworkImage(
                              product.thumbnail ?? "",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: TSize.s08,
                      end: TSize.s08,
                      child: FavoriteIconWidget(
                        onPressed: () {},
                        isFavorite: product.isFavorite,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TPadding.p08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
