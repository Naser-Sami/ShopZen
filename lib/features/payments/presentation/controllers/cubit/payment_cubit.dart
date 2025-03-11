import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/_core.dart' show PaymentCard;

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit()
      : super(const PaymentState(
          cards: [],
        ));

  void addCard(PaymentCard card) {
    emit(state.copyWith(cards: [...state.cards, card]));
  }
}
