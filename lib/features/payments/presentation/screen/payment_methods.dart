import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show TextWidget, TSize;
import '/features/payments/_payment.dart' show AddNewCardScreen, paymentAppBar;

class PaymentMethodsScreen extends StatelessWidget {
  static const routeName = '/payment-methods';
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: paymentAppBar(context, title: 'Payment Methods'),
      body: Center(
        child: TextButton(
          onPressed: () {
            context
                .push('${PaymentMethodsScreen.routeName}/${AddNewCardScreen.routeName}');
          },
          child: const TextWidget('Payment Methods'),
        ),
      ),
    );
  }
}
