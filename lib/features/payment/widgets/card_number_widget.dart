import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class CardNumberWidget extends StatelessWidget {
  const CardNumberWidget({super.key, this.controller, this.paymentCard});

  final TextEditingController? controller;
  final PaymentCard? paymentCard;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldComponent(
      title: 'Card Number',
      textFieldWithTitle: true,
      hintText: 'Enter your card number',
      controller: controller,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CardUtils.getCardIcon(paymentCard?.type),
      ),
      onSaved: (String? value) {
        log('onSaved = $value');
        log('Num controller has = ${controller?.text}');
        paymentCard?.number = CardUtils.getCleanedNumber(value!);
      },
      validator: CardUtils.validateCardNum,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(19),
        CardNumberInputFormatter()
      ],
    );
  }
}
