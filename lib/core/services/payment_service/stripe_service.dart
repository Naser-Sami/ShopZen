import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '/core/_core.dart' show DioService;

class StripeService {
  static final DioService dioService = DioService();
  static final String _secretKey = dotenv.env['STRIPE_SECRET'].toString();
  static const String _baseUrl = 'https://api.stripe.com/v1';

  // Initialize Stripe
  static void init() {
    Stripe.publishableKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx';
  }

  // Create a Payment Intent
  static Future<Map<String, dynamic>?> createPaymentIntent({
    required double amount,
    required String currency,
  }) async {
    try {
      int amountInCents = (amount * 100).toInt(); // Convert to smallest currency unit

      final headers = {
        'Authorization': 'Bearer $_secretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      Map<String, dynamic> body = {
        'amount': amountInCents.toString(),
        'currency': currency,
        // check how to implement the payment method types
        'payment_method_types[]': 'card',
      };

      final response = await dioService.post<Map<String, dynamic>>(
        path: "$_baseUrl/payment_intents",
        headers: headers,
        data: body,
      );

      return response;
    } catch (e) {
      throw Exception('Error creating payment intent: $e');
    }
  }

  // Confirm Payment
  static Future<void> processPayment({
    required double amount,
    required String currency,
  }) async {
    try {
      final paymentIntent = await createPaymentIntent(amount: amount, currency: currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          merchantDisplayName: 'ShopZen',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception('Payment failed:---> $e');
    }
  }

  /*  ==============================================================================================================================================================
      ==============================================================================================================================================================
      ==============================================================================================================================================================
      ==============================================================================================================================================================
      */

  static void handleCardPayment({
    required bool complete,
    required String cardNumber,
    int? expiryMonth,
    int? expiryYear,
    String? cvc,
    required double amount, // Include amount as a required parameter
    required String currency, // Add the currency parameter (e.g., 'usd')
  }) async {
    final card = CardFieldInputDetails(
      complete: complete,
      number: cardNumber,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvc: cvc,
    );

    await _processPayment(card, amount, currency);
  }

  // Process Payment
  static Future<void> _processPayment(
      CardFieldInputDetails card, double amount, String currency) async {
    try {
      // Step 1: Tokenize the card details
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      // Log the payment method
      log('Payment method tokenized: ${paymentMethod.id}');

      // Step 2: Send tokenized payment method to your backend for processing
      // You'll send the payment method id and the amount to the backend here
      final response = await dioService.post(
        path: '/your-backend-endpoint', // Your backend endpoint
        data: {
          'paymentMethodId': paymentMethod.id,
          'amount': (amount * 100).toInt(), // Convert amount to cents
          'currency': currency,
        },
      );

      // Handle backend response
      if (response['status'] == 'succeeded') {
        log('Payment successful!');
      } else {
        log('Payment failed');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
