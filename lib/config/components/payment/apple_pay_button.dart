import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '/core/_core.dart' show defaultApplePay;

class ApplePayButtonWidget extends StatelessWidget {
  const ApplePayButtonWidget({super.key, required this.paymentItems});

  final List<PaymentItem> paymentItems;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return ApplePayButton(
        paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
        paymentItems: paymentItems,
        style: ApplePayButtonStyle.automatic,
        type: ApplePayButtonType.buy,
        cornerRadius: 8,
        onPaymentResult: (paymentResult) => log(paymentResult.toString()),
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox();
  }
}
