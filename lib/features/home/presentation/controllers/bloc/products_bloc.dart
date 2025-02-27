import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/features/_features.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductRepository productRepository;
  final IGetProductCategoryListRepository getProductCategoryListRepository;
  final IGetProductsByCategoryRepository getProductsByCategoryRepository;

  int totalProducts = 0;
  bool isLoadingMoreData = false;

  ProductsBloc({
    required this.productRepository,
    required this.getProductCategoryListRepository,
    required this.getProductsByCategoryRepository,
  }) : super(ProductsInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<ToggleFavoriteEvent>(_onToggleFavoriteEvent);
    on<GetProductCategoryListEvent>(_onGetProductCategoryListEvent);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategoryEvent);
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

      List<String> existingCategories =
          state is ProductsLoadedState ? (state as ProductsLoadedState).categories : [];

      List<ProductEntity> existingProductsByCategory = state is ProductsLoadedState
          ? (state as ProductsLoadedState).productsByCategory
          : [];

      emit(ProductsLoadedState(products,
          categories: existingCategories,
          productsByCategory: existingProductsByCategory));
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

      emit(ProductsLoadedState(updatedProducts,
          categories: state.categories, productsByCategory: state.productsByCategory));
    }
  }

  Future<void> _onGetProductCategoryListEvent(
      GetProductCategoryListEvent event, Emitter<ProductsState> emit) async {
    try {
      final categories = await getProductCategoryListRepository.getProductCategoryList();

      if (state is ProductsLoadedState) {
        final currentState = state as ProductsLoadedState;
        emit(currentState.copyWith(categories: categories));
      } else {
        emit(ProductsLoadedState(const [], categories: categories));
      }
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }

  Future<void> _onGetProductsByCategoryEvent(
      GetProductsByCategoryEvent event, Emitter<ProductsState> emit) async {
    try {
      final productsByCategory =
          await getProductsByCategoryRepository.getProductsByCategory(event.category);
      if (state is ProductsLoadedState) {
        final currentState = state as ProductsLoadedState;
        emit(currentState.copyWith(productsByCategory: productsByCategory));
      } else {
        emit(ProductsLoadedState(const [], productsByCategory: productsByCategory));
      }
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }
}
