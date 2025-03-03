import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '/config/_config.dart';
import '../payment_configurations.dart';

class ApplePayButtonWidget extends StatefulWidget {
  const ApplePayButtonWidget({super.key, required this.paymentItems});

  final List<PaymentItem> paymentItems;

  @override
  State<ApplePayButtonWidget> createState() => _ApplePayButtonWidgetState();
}

class _ApplePayButtonWidgetState extends State<ApplePayButtonWidget> {
  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
    log('Apple Pay Result: $paymentResult');

    // Apple Pay Result:
    //  {transactionIdentifier: Simulated Identifier, paymentMethod: {network: AmEx, displayName: Simulated Instrument, type: 0}, token: }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      final size = MediaQuery.of(context).size;

      return SizedBox(
        height: TSize.s40,
        width: size.width,
        child: ApplePayButton(
          paymentConfiguration: defaultApplePayConfig,
          paymentItems: widget.paymentItems,
          style: ApplePayButtonStyle.automatic,
          type: ApplePayButtonType.buy,
          onPaymentResult: onApplePayResult,
          loadingIndicator: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
