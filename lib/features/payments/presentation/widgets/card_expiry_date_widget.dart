import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class CardExpiryDateWidget extends StatelessWidget {
  const CardExpiryDateWidget({
    super.key,
    this.controller,
    this.paymentCard,
    this.onCardUpdated,
  });

  final TextEditingController? controller;
  final PaymentCard? paymentCard;
  final Function(PaymentCard)? onCardUpdated; // This notifies the parent
  @override
  Widget build(BuildContext context) {
    return TextFormFieldComponent(
      title: 'Expiry Date',
      textFieldWithTitle: true,
      hintText: 'MM/YY',
      controller: controller,
      validator: CardUtils.validateDate,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          List<int> expiryDate = CardUtils.getExpiryDate(value);
          PaymentCard updatedCard = paymentCard!.copyWith(
            month: expiryDate[0],
            year: expiryDate[1],
          );
          onCardUpdated?.call(updatedCard);
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        CardMonthInputFormatter()
      ],
    );
  }
}
