import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class PopularSearchesWidget extends StatefulWidget {
  const PopularSearchesWidget({super.key});

  @override
  State<PopularSearchesWidget> createState() => _PopularSearchesWidgetState();
}

class _PopularSearchesWidgetState extends State<PopularSearchesWidget> {
  final popularSearches = [
    'Jeans',
    'Casual' 'clothes',
    'Hoodie',
    'Nike' 'shoes' 'black',
    ' V-neck t-shirt',
    ' Winter clothes'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                'Popular Searches',
                style: theme.textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: TextWidget(
                  'Clear All',
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
          TSize.s16.toHeight,
          Expanded(
            child: ListView.separated(
              itemCount: popularSearches.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      popularSearches[index],
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: IconWidget(name: 'cancel-circle'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
