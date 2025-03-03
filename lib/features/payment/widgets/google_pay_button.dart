import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '/config/_config.dart';
import '../payment_configurations.dart';

class GooglePayButtonWidget extends StatefulWidget {
  const GooglePayButtonWidget({super.key, required this.paymentItems});

  final List<PaymentItem> paymentItems;

  @override
  State<GooglePayButtonWidget> createState() => _GooglePayButtonWidgetState();
}

class _GooglePayButtonWidgetState extends State<GooglePayButtonWidget> {
  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    log('Google Pay Result: $paymentResult');
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      final size = MediaQuery.of(context).size;

      return SizedBox(
        height: TSize.s40,
        width: size.width,
        child: GooglePayButton(
          paymentConfiguration: defaultGooglePayConfig,
          paymentItems: widget.paymentItems,
          onPaymentResult: onGooglePayResult,
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
