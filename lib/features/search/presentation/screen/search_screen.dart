import 'dart:async';

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
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(SearchResetEvent()); // Reset state when screen opens
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      if (query.isNotEmpty) {
        context.read<SearchBloc>().add(SearchProductEvent(query));
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    context.read<SearchBloc>().add(SearchResetEvent());
    super.dispose();
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
              onChanged: _onSearchChanged,
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
                    return const PopularSearchesWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
