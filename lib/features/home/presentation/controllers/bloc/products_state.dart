part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<ProductEntity> products;
  final List<String> categories;
  final List<ProductEntity> productsByCategory;
  final List<ProductEntity> favoriteProducts;

  const ProductsLoadedState(this.products,
      {this.categories = const [],
      this.productsByCategory = const [],
      this.favoriteProducts = const []});

  @override
  List<Object> get props => [products, categories, productsByCategory, favoriteProducts];

  ProductsLoadedState copyWith(
      {List<ProductEntity>? products,
      List<String>? categories,
      List<ProductEntity>? productsByCategory,
      List<ProductEntity>? favoriteProducts}) {
    return ProductsLoadedState(
      products ?? this.products,
      categories: categories ?? this.categories,
      productsByCategory: productsByCategory ?? this.productsByCategory,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
    );
  }
}

class ProductsErrorState extends ProductsState {
  final String error;
  const ProductsErrorState(this.error);
  @override
  List<Object> get props => [error];
}
