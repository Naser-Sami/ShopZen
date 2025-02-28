import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '/features/cart/_cart.dart';
import '/config/_config.dart';
import '/core/_core.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key, required this.cart});

  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cart.products.length,
      itemBuilder: (context, index) {
        final product = cart.products[index];
        return SizedBox(
          height: TSize.s100,
          child: Slidable(
            dragStartBehavior: DragStartBehavior.start,
            key: ValueKey('slidable${product.id}'),
            endActionPane: ActionPane(
              extentRatio: 0.25,
              motion: Container(
                margin: const EdgeInsets.fromLTRB(TSize.s24, 0, 0, 0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer.withValues(alpha: 0.35),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(TPadding.p26),
                  child: IconWidget(name: 'delete'),
                ),
              ),
              children: const [],
            ),
            child: ListTile(
              key: ValueKey(product.id),
              isThreeLine: true,
              contentPadding: const EdgeInsets.all(TPadding.p16),
              shape: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.25),
                ),
              ),
              leading: Container(
                width: TSize.s80,
                height: TSize.s80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withValues(alpha: 0.05),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(TRadius.r08),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      product.thumbnail ?? "",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: TextWidget(
                product.title.toString(),
                style: theme.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget('Size: XL'),
                  TextWidget(
                    '\$${product.price}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 66,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(TSize.s04),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.outline.withValues(alpha: 0.40),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(TRadius.r04),
                            ),
                          ),
                          child: const Icon(
                            Icons.minimize,
                            size: 16,
                          ),
                        ),
                        TextWidget(
                          product.quantity.toString(),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(TSize.s04),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(TRadius.r04),
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            color: theme.colorScheme.onPrimary,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
