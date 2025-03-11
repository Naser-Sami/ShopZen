import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(const GetProductCategoryListEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: TSize.s96,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          switch (state) {
            case ProductsLoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProductsLoadedState():
              final categories = state.categories;

              return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: TSize.s16),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsetsDirectional.only(start: TSize.s20)
                        : EdgeInsets.zero,
                    child: GestureDetector(
                      onTap: () {
                        final category = categories[index];

                        context.push(
                          '${HomeScreen.routeName}/${ProductsByCategoryScreen.routeName}/$index',
                          extra: category,
                        );
                      },
                      child: SizedBox(
                        width: TSize.s66,
                        child: Column(
                          children: [
                            Container(
                              height: TSize.s55,
                              width: TSize.s55,
                              padding: const EdgeInsets.all(TPadding.p12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(TRadius.r08),
                                color: theme.colorScheme.primary.withValues(alpha: 0.05),
                              ),
                              child: IconWidget(
                                name: categories[index],
                                color: theme.colorScheme.outline,
                              ),
                            ),
                            TSize.s04.toHeight,
                            TextWidget(
                              categories[index]
                                  .replaceAll('womens', 'w')
                                  .replaceAll('mens', 'm')
                                  .toCapitalized,
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );

            case ProductsErrorState():
              final error = state.error;
              return Center(
                child: TextWidget(
                  error,
                  style: theme.textTheme.bodyMedium,
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
