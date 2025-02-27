import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/_core.dart';
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
    on<LoadFavoriteProductsEvent>(_onLoadFavoriteProducts);
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

      List<ProductEntity> existingFavoriteProducts = state is ProductsLoadedState
          ? (state as ProductsLoadedState).favoriteProducts
          : [];

      emit(ProductsLoadedState(products,
          categories: existingCategories,
          productsByCategory: existingProductsByCategory,
          favoriteProducts: existingFavoriteProducts));
      isLoadingMoreData = false;
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
      isLoadingMoreData = false;
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
        emit(
          currentState.copyWith(
            productsByCategory: productsByCategory,
            categories: currentState.categories,
            favoriteProducts: currentState.favoriteProducts,
          ),
        );
      } else {
        emit(ProductsLoadedState(const [], productsByCategory: productsByCategory));
      }
    } catch (e) {
      emit(ProductsErrorState(e.toString()));
    }
  }

  Future<void> _onToggleFavoriteEvent(
      ToggleFavoriteEvent event, Emitter<ProductsState> emit) async {
    final box = sl<IHiveService<ProductEntity>>();

    if (state is ProductsLoadedState) {
      final currentState = state as ProductsLoadedState;
      final updatedProducts = currentState.products.map((product) {
        if (product.id == event.product.id) {
          final updatedProduct = product.copyWith(isFavorite: !product.isFavorite);

          if (updatedProduct.isFavorite) {
            box.put(updatedProduct.id, updatedProduct);
          } else {
            box.delete(updatedProduct.id);
          }

          return updatedProduct;
        }
        return product;
      }).toList();

      emit(ProductsLoadedState(updatedProducts,
          categories: currentState.categories,
          productsByCategory: currentState.productsByCategory,
          favoriteProducts: currentState.favoriteProducts));
    }
  }

  void _onLoadFavoriteProducts(
      LoadFavoriteProductsEvent event, Emitter<ProductsState> emit) async {
    final box = sl<IHiveService<ProductEntity>>();
    final favoriteProducts = box.getAll();

    if (state is ProductsLoadedState) {
      final currentState = state as ProductsLoadedState;
      emit(currentState.copyWith(favoriteProducts: favoriteProducts));
    } else {
      emit(ProductsLoadedState(const [], favoriteProducts: favoriteProducts));
    }
  }
}
