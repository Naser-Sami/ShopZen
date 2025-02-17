part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductsEvent {
  final int limit;
  final int skip;
  final String? select;

  const FetchProductsEvent({this.limit = 30, this.skip = 0, this.select});

  @override
  List<Object?> get props => [limit, skip, select];
}

class ToggleFavoriteEvent extends ProductsEvent {
  final ProductEntity product;
  const ToggleFavoriteEvent({required this.product});
  @override
  List<Object> get props => [product];
}
