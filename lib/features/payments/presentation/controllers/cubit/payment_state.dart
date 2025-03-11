part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  const PaymentState({required this.cards});

  final List<PaymentCard> cards;

  // copy with
  PaymentState copyWith({
    List<PaymentCard>? cards,
  }) {
    return PaymentState(
      cards: cards ?? this.cards,
    );
  }

  // fromJson
  factory PaymentState.fromJson(Map<String, dynamic> json) {
    return PaymentState(
      cards:
          (json['cards'] as List<dynamic>).map((e) => PaymentCard.fromJson(e)).toList(),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'cards': cards.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [cards];
}
