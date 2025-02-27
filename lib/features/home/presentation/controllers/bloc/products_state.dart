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

  const ProductsLoadedState(this.products, {this.categories = const []});

  @override
  List<Object> get props => [products, categories];

  ProductsLoadedState copyWith(
      {List<ProductEntity>? products, List<String>? categories}) {
    return ProductsLoadedState(
      products ?? this.products,
      categories: categories ?? this.categories,
    );
  }
}

class ProductsErrorState extends ProductsState {
  final String error;
  const ProductsErrorState(this.error);
  @override
  List<Object> get props => [error];
}
