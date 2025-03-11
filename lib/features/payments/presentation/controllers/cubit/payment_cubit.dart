import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '/core/_core.dart' show PaymentCard;

part 'payment_state.dart';

class PaymentCubit extends HydratedCubit<PaymentState> {
  PaymentCubit()
      : super(const PaymentState(
          cards: [],
        ));

  void addCard(PaymentCard card) {
    emit(state.copyWith(cards: [...state.cards, card]));
  }

  void deleteCard(String id) {
    final updatedCards = state.cards.where((card) => card.id != id).toList();
    emit(state.copyWith(cards: updatedCards));
  }

  @override
  PaymentState? fromJson(Map<String, dynamic> json) {
    return PaymentState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PaymentState state) {
    return state.toJson();
  }
}
