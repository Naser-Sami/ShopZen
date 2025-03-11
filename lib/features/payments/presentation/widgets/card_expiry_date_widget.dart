import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class CardExpiryDateWidget extends StatelessWidget {
  const CardExpiryDateWidget({super.key, this.controller, this.paymentCard});

  final TextEditingController? controller;
  final PaymentCard? paymentCard;

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
        List<int> expiryDate = CardUtils.getExpiryDate(value!);
        paymentCard?.month = expiryDate[0];
        paymentCard?.year = expiryDate[1];
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        CardMonthInputFormatter()
      ],
    );
  }
}
