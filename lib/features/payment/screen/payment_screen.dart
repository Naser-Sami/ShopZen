import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart' as pay;
import 'package:shop_zen/features/payment/widgets/_widgets.dart';

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

  final _formKey = GlobalKey<FormState>();
  final _cartNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();

  final _paymentCard = PaymentCard();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

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
    _paymentCard.type = CardType.others;
    _cartNumberController.addListener(_getCardTypeFrmNumber);
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(_cartNumberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: paymentAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Apple Pay Button -> Only for iOS
              ApplePayButtonWidget(paymentItems: _paymentItems),

              /// Google Pay Button -> Only for Android
              GooglePayButtonWidget(paymentItems: _paymentItems),

              /// Spacing
              const SizedBox(height: TSize.s16),

              /// Credit Card Details
              TextWidget(
                'Add Debit/Credit Card',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: TSize.s16),

              /// Card Number
              CardNumberWidget(
                controller: _cartNumberController,
                paymentCard: _paymentCard,
              ),
              const SizedBox(height: TSize.s16),

              /// .. Card expired date & CVC
              Row(
                children: [
                  // Expiry date
                  Expanded(
                    child: CardExpiryDateWidget(
                      controller: _expiryDateController,
                      paymentCard: _paymentCard,
                    ),
                  ),
                  const SizedBox(width: TSize.s16),

                  // CVC
                  Expanded(
                    child: CardCvcWidget(
                      controller: _cvcController,
                      paymentCard: _paymentCard,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSize.s48),
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
      ),
    );
  }

  Future<void> _validateInputs() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
      });
      ToastNotification.showErrorNotification(context,
          message: 'Please enter all the details');
    } else {
      form.save();
      await makePayment();
      // Encrypt and send send payment details to payment gateway
      if (mounted) {
        ToastNotification.showSuccessNotification(context,
            message: 'Payment card is valid');
      }
    }
  }

  Widget _getPayButton() {
    if (Platform.isIOS) {
      return SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          color: Theme.of(context).colorScheme.primary,
          onPressed: _validateInputs,
          child: TextWidget(
            AppConfig.pay,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: _validateInputs,
        child: TextWidget(
          AppConfig.pay.toUpperCase(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _card = CardDetails();

    // Clean up the controller when the Widget is removed from the Widget tree
    _cartNumberController.removeListener(_getCardTypeFrmNumber);
    _cartNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }
}
