import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/features/_features.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchProductRepository searchProductRepository;

  SearchBloc({required this.searchProductRepository}) : super(SearchInitial()) {
    on<SearchProductEvent>(_onSearchProductEvent);
  }

  Future<void> _onSearchProductEvent(
      SearchProductEvent event, Emitter<SearchState> emit) async {
    try {
      emit(SearchLoadingState());
      final products = await searchProductRepository.searchProduct(event.query);
      emit(SearchLoadedState(products, event.query));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
}
