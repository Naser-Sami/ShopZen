import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart' show TextWidget, TSize;
import '/features/payments/_payment.dart' show AddNewCardScreen, paymentAppBar;

class PaymentMethodsScreen extends StatelessWidget {
  static const routeName = '/payment-methods';
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: paymentAppBar(context, title: 'Payment Methods'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSize.s20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextWidget(
                      'Saved Cards',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: TSize.s16),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(
                      '${PaymentMethodsScreen.routeName}/${AddNewCardScreen.routeName}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: theme.colorScheme.onSurface,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSize.s08),
                    side: BorderSide(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: theme.colorScheme.onSurface,
                      size: 30,
                    ),
                    const SizedBox(width: TSize.s10),
                    TextWidget(
                      'Add New Card',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
