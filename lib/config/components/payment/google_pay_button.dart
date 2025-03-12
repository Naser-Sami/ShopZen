import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '/core/_core.dart' show defaultGooglePay, TFunctions;

class GooglePayButtonWidget extends StatelessWidget {
  const GooglePayButtonWidget({super.key, required this.paymentItems});

  final List<PaymentItem> paymentItems;

  @override
  Widget build(BuildContext context) {
    final theme = TFunctions.isDarkMode(context)
        ? GooglePayButtonTheme.dark
        : GooglePayButtonTheme.light;

    if (Platform.isAndroid) {
      return GooglePayButton(
        paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
        paymentItems: paymentItems,
        onPaymentResult: (paymentResult) => log(paymentResult.toString()),
        theme: theme,
        cornerRadius: 8,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return const SizedBox();
  }
}
