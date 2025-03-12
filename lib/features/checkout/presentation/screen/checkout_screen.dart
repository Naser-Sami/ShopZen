import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay/pay.dart' show PaymentItem, PaymentItemStatus;
import 'package:shop_zen/config/theme/dimension/_dimension.dart';

import '/core/_core.dart' show PaymentCard, StripeService, CardUtils, CardNumberFormatter;
import '/config/_config.dart'
    show
        NotificationsIconWidget,
        TPadding,
        TextWidget,
        TSize,
        IconWidget,
        ApplePayButtonWidget,
        GooglePayButtonWidget;
import '/features/_features.dart'
    show
        AddressScreen,
        AddressCubit,
        AddressState,
        AddressEntity,
        PaymentCubit,
        PaymentState;

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // example list
    List<PaymentItem> paymentItems = const [
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item B',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Total',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      ),
    ];

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
                  BlocSelector<AddressCubit, AddressState, List<AddressEntity>>(
                    selector: (state) => state.address,
                    builder: (context, address) {
                      if (address.isEmpty) {
                        return IconButton(
                            onPressed: () {
                              context.push(AddressScreen.routeName);
                            },
                            icon: const Icon(Icons.add));
                      }
                      return TextButton(
                        onPressed: () {
                          context.push(AddressScreen.routeName);
                        },
                        child: TextWidget(
                          'Change',
                          style: theme.textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: TSize.s16),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state.address.isEmpty) {
                    return SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'No address found',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }

                  final selectedIndex = state.address
                      .indexWhere((address) => state.selectedAddress == address.id);
                  final addr = selectedIndex != -1
                      ? state.address[selectedIndex]
                      : state.address.first;

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: IconWidget(
                      name: 'location',
                      height: 30,
                      color: theme.colorScheme.outline,
                    ),
                    title: TextWidget(
                      addr.addressNickname,
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: TextWidget(addr.fullAddress),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: TRadius.r08),
                child: Divider(),
              ),
              TextWidget(
                'Payment Method',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: TSize.s16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TRadius.r08),
                          border: Border.all(
                            color: theme.colorScheme.outline,
                          ),
                          color: theme.colorScheme.primary),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          TextWidget(
                            'Card',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: TSize.s16),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TPadding.p06),
                          border: Border.all(
                            color: theme.colorScheme.outline,
                          ),
                          color: theme.colorScheme.surface),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.money_sharp,
                              color: theme.colorScheme.onSurface,
                              size: 20,
                            ),
                          ),
                          TextWidget(
                            'Cash',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSize.s16),
              if (Platform.isIOS)
                SizedBox(
                  height: 44,
                  width: double.infinity,
                  child: ApplePayButtonWidget(
                    paymentItems: paymentItems,
                  ),
                ),
              if (Platform.isAndroid)
                SizedBox(
                  height: 44,
                  width: double.infinity,
                  child: GooglePayButtonWidget(
                    paymentItems: paymentItems,
                  ),
                ),
              const SizedBox(height: TSize.s16),
              BlocSelector<PaymentCubit, PaymentState, List<PaymentCard>>(
                selector: (state) => state.cards,
                builder: (context, cards) {
                  if (cards.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  final card = cards.firstWhere(
                    (card) => card.isDefault == true,
                  );

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsetsDirectional.all(8.0)
                          .copyWith(start: 20, end: 0),
                      child: CardUtils.getCardIcon(card.type),
                    ),
                    title: TextWidget(
                      card.number?.formattedCardNumber ?? '',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_outlined,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: TSize.s16),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: TPadding.p16),
                child: Divider(),
              ),
              ElevatedButton(
                onPressed: () {
                  // StripePaymentHandle().stripeMakePayment();
                  makePayment();
                },
                child: const TextWidget('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void makePayment() async {
    try {
      await StripeService.processPayment(amount: 19.99, currency: 'usd');
      log('Payment Successful');
    } catch (e) {
      log('Payment Failed: $e');
    }
  }
}
