import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/common/_common.dart';
import '/features/_features.dart' show AddressScreen;
import '/config/_config.dart' show NotificationsIconWidget, TPadding, TextWidget, TSize;

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        actions: const [NotificationsIconWidget()],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 10),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TPadding.p20),
            child: Divider(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    'Delivery Address',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // show if there's an address
                  if (false)
                    TextButton(
                      onPressed: () {},
                      child: TextWidget(
                        'Change',
                        style: theme.textTheme.titleSmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: TSize.s16),

              // if address is empty
              if (true) ...[
                ElevatedButton(
                  onPressed: () {
                    context.push(AddressScreen.routeName);
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
                        'Add New Address',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: IconWidget(
                    name: 'location',
                    height: 30,
                    color: theme.colorScheme.outline,
                  ),
                  title: TextWidget(
                    'Home',
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: const TextWidget('123 Main Street, New York, NY 10001'),
                ),
              ],

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TPadding.p16),
                child: Divider(),
              ),
              TextWidget(
                'Payment Method',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: TPadding.p16),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
