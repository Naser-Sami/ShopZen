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

  const ProductsLoadedState(this.products,
      {this.categories = const [], this.productsByCategory = const []});

  @override
  List<Object> get props => [products, categories, productsByCategory];

  ProductsLoadedState copyWith(
      {List<ProductEntity>? products,
      List<String>? categories,
      List<ProductEntity>? productsByCategory}) {
    return ProductsLoadedState(
      products ?? this.products,
      categories: categories ?? this.categories,
      productsByCategory: productsByCategory ?? this.productsByCategory,
    );
  }
}

class ProductsErrorState extends ProductsState {
  final String error;
  const ProductsErrorState(this.error);
  @override
  List<Object> get props => [error];
}
