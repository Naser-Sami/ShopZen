import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class CardCvcWidget extends StatelessWidget {
  const CardCvcWidget({super.key, this.controller, this.paymentCard});

  final TextEditingController? controller;
  final PaymentCard? paymentCard;

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
        paymentCard?.cvv = int.parse(value!);
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
    );
  }
}
