import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show CardNumberFormatter, CardUtils, PaymentCard;
import '/config/_config.dart' show TextWidget, TSize;
import '/features/payments/_payment.dart'
    show AddNewCardScreen, PaymentCubit, PaymentState, paymentAppBar;

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
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.cards.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: TSize.s16),
                          itemBuilder: (context, index) {
                            final card = state.cards[index];

                            return Dismissible(
                              key: ValueKey(card.id),
                              background: _swipeToDelete(),
                              onDismissed: (direction) {
                                context.read<PaymentCubit>().deleteCard(card.id ?? "");
                              },
                              child: RadioListTile(
                                secondary: Padding(
                                  padding: const EdgeInsetsDirectional.all(8.0)
                                      .copyWith(start: 20, end: 0),
                                  child: CardUtils.getCardIcon(card.type),
                                ),
                                title: Row(
                                  children: [
                                    TextWidget(
                                      card.number?.formattedCardNumber ?? '',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    if (card.isDefault ?? false)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: ColoredBox(
                                          color: theme.colorScheme.outline
                                              .withValues(alpha: 0.20),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 9, vertical: 3),
                                            child: TextWidget(
                                              'Default',
                                              style: theme.textTheme.titleSmall?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                controlAffinity: ListTileControlAffinity.trailing,
                                value: card.id ?? "",
                                groupValue: state.cards
                                        .firstWhere(
                                          (c) => c.isDefault == true,
                                          orElse: () => const PaymentCard(
                                              id: ""), // Fallback if no default card
                                        )
                                        .id ??
                                    "",
                                onChanged: (String? value) {
                                  context
                                      .read<PaymentCubit>()
                                      .setAsDefault(card.id ?? "");
                                },
                                activeColor: theme.colorScheme.onSurface,
                                contentPadding: EdgeInsets.zero,
                                tileColor:
                                    theme.colorScheme.onSurface.withValues(alpha: 0.03),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.2),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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

  Widget? _swipeToDelete() => const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_outline,
            color: Colors.grey,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Delete Card",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      );
}
