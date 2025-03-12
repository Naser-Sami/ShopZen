import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart';
import 'package:shop_zen/core/utils/_utils.dart';

import '/core/_core.dart' show defaultGooglePay;
import '../../../features/payment_ss/payment_service.dart';

class GooglePayButtonWidget extends StatefulWidget {
  const GooglePayButtonWidget({super.key, required this.paymentItems});

  final List<PaymentItem> paymentItems;

  @override
  State<GooglePayButtonWidget> createState() => _GooglePayButtonWidgetState();
}

class _GooglePayButtonWidgetState extends State<GooglePayButtonWidget> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return GooglePayButton(
        paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
        paymentItems: widget.paymentItems,
        onPressed: () {},
        onPaymentResult: onGooglePayResult,
        theme: TFunctions.isDarkMode(context)
            ? GooglePayButtonTheme.dark
            : GooglePayButtonTheme.light,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return const SizedBox();
  }

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
}
