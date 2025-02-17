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

  const ProductsLoadedState(this.products);
  @override
  List<Object> get props => [products];
}

class ProductsErrorState extends ProductsState {
  final String error;
  const ProductsErrorState(this.error);
  @override
  List<Object> get props => [error];
}
