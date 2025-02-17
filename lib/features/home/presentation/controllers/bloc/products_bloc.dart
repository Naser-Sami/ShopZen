import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/features/_features.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductRepository productRepository;

  int totalProducts = 0;
  bool isLoadingMoreData = false;

  ProductsBloc({required this.productRepository}) : super(ProductsInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<ToggleFavoriteEvent>(_onToggleFavoriteEvent);
  }

  Future<void> _onFetchProducts(
      FetchProductsEvent event, Emitter<ProductsState> emit) async {
    if (isLoadingMoreData) return;

    try {
      isLoadingMoreData = true;

      if (state is ProductsInitial) {
        emit(ProductsLoadingState());
      }

      totalProducts = productRepository.totalProducts;

      final products = await productRepository.getAllProducts(
        limit: event.limit,
        skip: event.skip,
        select: event.select,
      );

      emit(ProductsLoadedState(products));
      isLoadingMoreData = false;
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
      isLoadingMoreData = false;
    }
  }

  void _onToggleFavoriteEvent(ToggleFavoriteEvent event, Emitter<ProductsState> emit) {
    if (state is ProductsLoadedState) {
      final state = this.state as ProductsLoadedState;
      final updatedProducts = state.products.map((product) {
        if (product.id == event.product.id) {
          return product.copyWith(isFavorite: !product.isFavorite);
        }
        return product;
      }).toList();

      emit(ProductsLoadedState(updatedProducts));
    }
  }
}
