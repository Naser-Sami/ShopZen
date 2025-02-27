import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              controller: _searchController,
              autofocus: true,
              onChanged: (String query) {
                // after 1 second, search
                // Future.delayed(const Duration(milliseconds: 1000), () {
                //   if (context.mounted) {
                //     context.read<SearchBloc>().add(SearchProductEvent(query));
                //   }
                // });
              },
              onSubmitted: (String query) {
                context.read<SearchBloc>().add(SearchProductEvent(query));
              },
            ),
            TSize.s24.toHeight,
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                switch (state) {
                  case SearchLoadingState():
                    return const Center(child: CircularProgressIndicator());
                  case SearchLoadedState():
                    final products = (state).products;

                    if (products.isEmpty) {
                      return const EmptySearchWidget();
                    }
                    return SearchResultWidget(products: products);
                  case SearchErrorState():
                    final error = (state).error;
                    return Text(error);
                  default:
                    return PopularSearchesWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
