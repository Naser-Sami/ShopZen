import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/_config.dart';
import '/features/home/_home.dart';

class HomeHotDeals extends StatefulWidget {
  const HomeHotDeals({super.key});

  @override
  State<HomeHotDeals> createState() => _HomeHotDealsState();
}

class _HomeHotDealsState extends State<HomeHotDeals> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(FetchProductsEvent(limit: 30, skip: 0));
  }

  @override
  Widget build(BuildContext context) {
    // final prodRepo = context.read<ProductsBloc>().productRepository;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductsErrorState) {
            return Center(child: Text("Error: ${state.error}"));
          }
          if (state is ProductsLoadedState) {
            final products = state.products;
            return ProductsListViewWidget(
              products: products,
            );
          }

          //  if (products.length < prodRepo.totalProducts)
          //         SliverToBoxAdapter(
          //           child: Center(
          //             child: SizedBox(
          //               height: 100,
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: CircularProgressIndicator.adaptive(),
          //               ),
          //             ),
          //           ),
          //         ),

          return Center(child: Text("No data"));
        },
      ),
    );
  }
}
