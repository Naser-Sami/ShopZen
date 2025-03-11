import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_zen/core/_core.dart';

class PaymentController {
  Future<bool?> payWithApplePay() async {
// Total Price
    double totalPrice = 50;
    try {
// Creating a payment intent, this will be used to get the client secret
      final paymentIntentResponse = await _getPaymentIntent({
        'amount': (totalPrice * 100).toInt().toString(),
        'currency': 'EUR',
        'payment_method_types[]': 'card',
      });
      if (paymentIntentResponse == null) {
        throw Exception('Failed to create payment intent');
      }
//client secret
      final String clientSecret = paymentIntentResponse['client_secret'];
// Presenting apple payment sheet
      final PaymentIntent paymentIntent =
          await Stripe.instance.confirmPlatformPayPaymentIntent(
        clientSecret: clientSecret,
        confirmParams: PlatformPayConfirmParams.applePay(
          applePay: ApplePayParams(
            merchantCountryCode: 'US',
            currencyCode: 'EUR',
            cartItems: [
              ApplePayCartSummaryItem.immediate(
                label: 'Item',
                amount: totalPrice.toString(),
              )
            ],
          ),
        ),
      );

      log('apple pay >> paymentIntent : $paymentIntent');

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        log('Payment Successful');
        return true;
      } else {
        throw Exception(paymentIntent.status);
      }
    } on PlatformException catch (exception) {
      log(exception.message ?? 'Something went wrong');
    } catch (exception) {
      log(exception.toString());
    }
    return false;
  }

// Creating a payment intent
  Future<Map<String, dynamic>?> _getPaymentIntent(Map<String, dynamic> data) async {
    final DioHelper dioHelper = DioHelper();

    try {
      final paymentIntentResponse = await dioHelper.post<Map<String, dynamic>>(
        path:
            'https://api.stripe.com/v1/payment_intents?amount=${data['amount']}&currency=${data['currency']}&payment_method_types[]=${data['payment_method_types[]']}',
        headers: <String, String>{
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
        },
      );
      var jsonData = paymentIntentResponse;
      return jsonData;
    } catch (exception) {
      log(exception.toString());
    }
    return null;
  }
}
