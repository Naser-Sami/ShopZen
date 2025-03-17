import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '/core/_core.dart' show DioService;

class StripeService {
  static final DioService dioService = DioService();
  static final String _secretKey = dotenv.env['STRIPE_SECRET'].toString();
  static final String _publishableKey =
      dotenv.env['STRIPE_PUBLISHABLE_KEY'].toString();
  static const String _baseUrl = 'https://api.stripe.com/v1';

  // Initialize Stripe
  static void init() {
    Stripe.publishableKey = _publishableKey;
  }

  // Create a Payment Intent
  static Future<Map<String, dynamic>?> createPaymentIntent({
    required double amount,
    required String currency,
  }) async {
    try {
      int amountInCents =
          (amount * 100).toInt(); // Convert to smallest currency unit

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
      final paymentIntent =
          await createPaymentIntent(amount: amount, currency: currency);

      log('message: paymentIntent-> $paymentIntent');

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

  // Handle Card Payment
  static Future<void> payWithCard({
    required double amount,
    required String currency,
  }) async {
    try {
      // 1. Create card payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(email: 'user@example.com'),
          ),
        ),
      );

      // 2. Fetch client secret from backend
      final paymentIntent =
          await createPaymentIntent(amount: amount, currency: currency);

      // 3. Confirm payment
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: paymentIntent?['client_secret'],
        data: PaymentMethodParams.cardFromMethodId(
          paymentMethodData: PaymentMethodDataCardFromMethod(
            paymentMethodId: paymentMethod.id,
          ),
        ),
      );

      log('Payment successful!');
    } catch (e) {
      log('Error: $e');
    }
  }
}
