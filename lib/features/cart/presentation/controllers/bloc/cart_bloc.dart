import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/features/cart/_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository repository;
  CartBloc(this.repository) : super(CartInitial()) {
    on<GetCartsEvent>(_getCarts);
  }

  Future<void> _getCarts(GetCartsEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await repository.getCartItems(event.id);
      if (cart != null) {
        emit(CartLoaded(cart));
      } else {
        emit(const CartError('No cart items found'));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
