import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/config/common/_common.dart';
import '/features/_features.dart'
    show AddressScreen, AddressCubit, AddressState, AddressEntity;
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
