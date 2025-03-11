import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show CardType, CardUtils, PaymentCard, successDialog;
import '/config/_config.dart' show TextWidget, TSize, TPadding;
import '/features/payments/_payment.dart'
    show
        CardNumberWidget,
        CardExpiryDateWidget,
        CardCvcWidget,
        PaymentCubit,
        paymentAppBar;

class AddNewCardScreen extends StatefulWidget {
  static const routeName = 'add-new-card';
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cartNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();

  final _paymentCard = PaymentCard();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(_cartNumberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  bool _isAllFieldsFilled() {
    if (_cartNumberController.text.isNotEmpty &&
        _expiryDateController.text.isNotEmpty &&
        _cvcController.text.isNotEmpty) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
      return true;
    }
    return false;
  }

  Future<void> _validateInputs() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
      });
    } else {
      form.save();
      // Encrypt and send send payment details to payment gateway

      // Add new card to the list
      log('_paymentCard => $_paymentCard');
      context.read<PaymentCubit>().addCard(_paymentCard);

      // show success dialog
      successDialog(context, message: 'Your new card has been added.');
    }
  }

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.others;
    _cartNumberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: paymentAppBar(context, title: 'New Card'),
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                onPressed: _isAllFieldsFilled() ? _validateInputs : null,
                child: const TextWidget('Add Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _cartNumberController.removeListener(_getCardTypeFrmNumber);
    _cartNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }
}
