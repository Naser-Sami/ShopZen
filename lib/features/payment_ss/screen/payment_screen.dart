import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart' as pay;
import 'package:shop_zen/features/payment_ss/widgets/_widgets.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment';
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  CardDetails _card = CardDetails();

  final List<pay.PaymentItem> _paymentItems = const [
    pay.PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: pay.PaymentItemStatus.final_price,
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('100', 'USD');
      log('Payment Intent: $paymentIntent');

      // // STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret:
              paymentIntent?['client_secret'], //Gotten from payment intent
          style: ThemeMode.system,
          merchantDisplayName: 'ShopZen',
        ),
      )
          .then((value) {
        // Display Payment sheet
        log('value-> $value');
      });

      // _card = CardDetails(
      //   number: _cartNumberController.text.replaceAll(' ', '').trim(),
      //   expirationMonth: int.tryParse(_expiryDateController.text.split('/')[0]),
      //   expirationYear: int.tryParse(_expiryDateController.text.split('/')[1]),
      //   cvc: _cvcController.text.trim(),
      // );

      // log('Card Details: $_card');

      /// Updates the internal card details.
      /// This method will not validate the card information so you should validate the information yourself.
      /// WARNING!!! Only do this if you're certain that you fulfill the necessary PCI compliance requirements.
      /// Make sure that you're not mistakenly logging or storing full card details!
      /// See the docs for details: https://stripe.com/docs/security/guide#validating-pci-compliance

      // await Stripe.instance.dangerouslyUpdateCardDetails(_card);
      await Stripe.instance.dangerouslyUpdateCardDetails(_card);

      //STEP 3: Display Payment sheet
      // displayPaymentSheet();
      // display the payment status as dialog or bottom sheet

      if (mounted) {
        ToastNotification.showSuccessNotification(context, message: 'Payment Successful');
      }
    } catch (err) {
      if (mounted) {
        ToastNotification.showErrorNotification(context, message: 'Payment Failed');
      }
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Apple Pay Button -> Only for iOS
            ApplePayButtonWidget(paymentItems: _paymentItems),

            /// Google Pay Button -> Only for Android
            GooglePayButtonWidget(paymentItems: _paymentItems),

            /// Spacing
            const SizedBox(height: TSize.s16),

            ElevatedButton(
              onPressed: () async {
                // await makePayment();

                final o = StripePaymentHandle();
                o.stripeMakePayment();

                // await Stripe.instance.initCustomerSheet(
                //   customerSheetInitParams: CustomerSheetInitParams(
                //     // Main params
                //     setupIntentClientSecret: paymentIntent?['client_secret'],
                //     merchantDisplayName: 'Flutter Stripe Store Demo',
                //     // Customer params
                //     customerId: '1234567890',
                //     customerEphemeralKeySecret: 'sk_test_1234567890',
                //     style: ThemeMode.system,
                //     defaultBillingDetails: const BillingDetails(
                //       name: 'John Doe',
                //       email: 'john@doe.com',
                //       phone: '1234567890',
                //       address: Address(
                //         city: 'San Francisco',
                //         country: 'USA',
                //         line1: '123 Main St',
                //         line2: 'Apt 4',
                //         state: 'CA',
                //         postalCode: '12345',
                //       ),
                //     ),
                //   ),
                // );
              },
              child: const TextWidget('Pay'),
            ),
            // _getPayButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _card = CardDetails();
    super.dispose();
  }
}
