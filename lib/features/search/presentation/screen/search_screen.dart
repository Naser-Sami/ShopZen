import 'package:flutter/material.dart';
import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final popularSearches = [
    'Jeans',
    'Casual' 'clothes',
    'Hoodie',
    'Nike' 'shoes' 'black',
    ' V-neck t-shirt',
    ' Winter clothes'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              autofocus: true,
            ),
            TSize.s24.toHeight,
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
      ),
    );
  }
}
