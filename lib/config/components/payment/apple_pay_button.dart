import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '/core/_core.dart' show defaultApplePay;
import '../../../features/payment_ss/payment_controller.dart';

class ApplePayButtonWidget extends StatefulWidget {
  const ApplePayButtonWidget({super.key, required this.paymentItems});

  final List<PaymentItem> paymentItems;

  @override
  State<ApplePayButtonWidget> createState() => _ApplePayButtonWidgetState();
}

class _ApplePayButtonWidgetState extends State<ApplePayButtonWidget> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return ApplePayButton(
        paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
        paymentItems: widget.paymentItems,
        style: ApplePayButtonStyle.automatic,
        type: ApplePayButtonType.buy,
        onPaymentResult: onApplePayResult,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox();
  }

  Future<void> onApplePayResult(paymentResult) async {
    final o = PaymentController();
    await o.payWithApplePay();
    // Send the resulting Apple Pay token to your server / PSP
    log('Apple Pay Result: $paymentResult');

    // Apple Pay Result:
    //  {transactionIdentifier: Simulated Identifier, paymentMethod: {network: AmEx, displayName: Simulated Instrument, type: 0}, token: }
  }
}
