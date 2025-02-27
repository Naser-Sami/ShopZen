part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchLoadedState extends SearchState {
  final List<ProductEntity> products;
  final String query;
  const SearchLoadedState(this.products, this.query);
  @override
  List<Object> get props => [products, query];
}

final class SearchErrorState extends SearchState {
  final String error;
  const SearchErrorState(this.error);
  @override
  List<Object> get props => [error];
}
