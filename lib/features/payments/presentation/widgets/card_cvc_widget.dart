import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class CardCvcWidget extends StatelessWidget {
  const CardCvcWidget({super.key, this.controller, this.paymentCard, this.onCardUpdated});

  final TextEditingController? controller;
  final PaymentCard? paymentCard;
  final Function(PaymentCard)? onCardUpdated; // This notifies the parent

  @override
  Widget build(BuildContext context) {
    return TextFormFieldComponent(
      title: 'Security Code',
      textFieldWithTitle: true,
      hintText: 'CVC',
      controller: controller,
      suffixIcon: const Icon(CupertinoIcons.question_circle),
      validator: CardUtils.validateCVV,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          PaymentCard updatedCard = paymentCard!.copyWith(
            cvv: int.parse(value),
          );
          onCardUpdated?.call(updatedCard);
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
    );
  }
}
