import 'dart:developer';

import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});

  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {
  List<CategoriesEntity> categories = [];

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    categories = await sl<ICategoriesRepository>().getCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: TSize.s80,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: TSize.s16),
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0
                ? EdgeInsetsDirectional.only(start: TSize.s20)
                : EdgeInsets.zero,
            child: GestureDetector(
              onTap: () {
                log(categories[index].name);
              },
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
                      name: categories[index].image,
                      color: categories[index].image == 'beauty'
                          ? null
                          : TFunctions.isDarkMode(context)
                              ? Colors.grey.shade200
                              : null,
                    ),
                  ),
                  TSize.s04.toHeight,
                  TextWidget(
                    categories[index].name,
                    style: theme.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
