import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '/core/_core.dart';
import 'payment_model.dart';

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment() async {
    try {
      paymentIntent = await createPaymentIntent('30', 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  billingDetails: const BillingDetails(
                    name: 'John Doe',
                    email: 'john@doe.com',
                    phone: '1234567890',
                    address: Address(
                      city: 'San Francisco',
                      country: 'USA',
                      line1: '123 Main St',
                      line2: 'Apt 4',
                      state: 'CA',
                      postalCode: '12345',
                    ),
                  ),
                  paymentIntentClientSecret:
                      paymentIntent!['client_secret'], //Gotten from payment intent
                  style: ThemeMode.system,
                  merchantDisplayName: 'ShopZen'))
          .then((value) {
        log(value.toString());
      });

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      log(e.toString());
      ToastNotification.showErrorNotification(navigatorKey.currentContext!,
          message: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      ToastNotification.showSuccessNotification(navigatorKey.currentContext!,
          message: 'Payment Successful');
    } on Exception catch (e) {
      if (e is StripeException) {
        ToastNotification.showErrorNotification(navigatorKey.currentContext!,
            message: e.error.localizedMessage);
      } else {
        ToastNotification.showErrorNotification(navigatorKey.currentContext!,
            message: 'Unforeseen error: ${e}');
      }
    }
  }

//calculate Amount
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}

createPaymentIntent(String amount, String currency) async {
  final DioHelper dioHelper = DioHelper();
  try {
    //Request body
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
    };

    // PaymentModel body = const PaymentModel();
    // body = body.copyWith(
    //   amount: calculateAmount(amount),
    //   currency: currency,
    // );

    // log('body message-> $body');

    final response = await dioHelper.post<Map<String, dynamic>>(
      path: "https://api.stripe.com/v1/payment_intents",
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      data: body,
    );

    log('response-> $response');

    // response->
    // {
    // id: pi_3QyU8v2eZvKYlo2C05Tqaho8,
    // object: payment_intent,
    // amount: 10000,
    // amount_capturable: 0,
    // amount_details: {tip: {}},
    // amount_received: 0,
    // application: null,
    // application_fee_amount: null,
    // automatic_payment_methods: {allow_redirects: always, enabled: true},
    // canceled_at: null,
    // cancellation_reason: null,
    // capture_method: automatic_async,
    // client_secret: pi_3QyU8v2eZvKYlo2C05Tqaho8_secret_UjKCoJGRBFKFh0kc7mLULNcMv,
    // confirmation_method: automatic,
    // created: 1740989669,
    // currency: usd,
    // customer: null,
    // description: null,
    // invoice: null,
    // last_payment_error: null,
    // latest_charge: null,
    // livemode: false,
    // metadata: {},
    // next_action: null,
    // on_behalf_of: null,
    // payment_method: null,
    // payment_method_configuration_details: {id: pmc_1JwXwt2eZvKYlo2CHV7mUH3p, parent: null},
    // payment_method_options: {card: {installments: null, mandate_options: null, network: null, request_three_d_secure: automatic},
    // link: {persistent_token: null}},
    // payment_method_types: [card, link],
    // processing: null,
    // receipt_email: null,
    // review: null,
    // setup_future_usage: null,
    // shipping: null,
    // source: null,
    // statement_descriptor: null,
    // statement_descriptor_suffix: null,
    // status: requires_payment_method,
    // transfer_data: null,
    // transfer_group: null
    // }

    return response;
  } catch (err) {
    throw Exception(err.toString());
  }
}

calculateAmount(String amount) {
  final calculatedAmount = (int.parse(amount)) * 100;
  return calculatedAmount.toString();
}
