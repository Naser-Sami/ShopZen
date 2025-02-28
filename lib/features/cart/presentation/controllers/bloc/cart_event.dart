part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartsEvent extends CartEvent {
  final String id;
  const GetCartsEvent({required this.id});
  @override
  List<Object> get props => [id];
}
