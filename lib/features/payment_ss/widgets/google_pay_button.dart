import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart';

import '../payment_service.dart';
import '/config/_config.dart';
import '../payment_configurations.dart';

class GooglePayButtonWidget extends StatefulWidget {
  const GooglePayButtonWidget({super.key, required this.paymentItems});

  final List<PaymentItem> paymentItems;

  @override
  State<GooglePayButtonWidget> createState() => _GooglePayButtonWidgetState();
}

class _GooglePayButtonWidgetState extends State<GooglePayButtonWidget> {
  // void onGooglePayResult(paymentResult) {
  //   // Send the resulting Google Pay token to your server / PSP
  //   log('Google Pay Result: $paymentResult');

  // }

  Future<void> onGooglePayResult(paymentResult) async {
    final response = await createPaymentIntent('150', 'USD');
    final clientSecret = response['clientSecret'];

    // Confirm Google pay payment method
    log('paymentResult >> $paymentResult');
    final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
    final tokenJson = Map.castFrom(json.decode(token));

    final params = PaymentMethodParams.cardFromToken(
      paymentMethodData: PaymentMethodDataCardFromToken(
        token: tokenJson['id'],
      ),
    );
    // Confirm Google pay payment method
    await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: params,
    );
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
