import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_picker_google/place_picker_google.dart' show LocationResult;

import '/features/_features.dart';
import '/config/_config.dart'
    show NotificationsIconWidget, TPadding, TextWidget, TSize, IconWidget;

class AddressScreen extends StatelessWidget {
  static const String routeName = '/address';
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        actions: const [NotificationsIconWidget()],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 10),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TPadding.p20),
            child: Divider(),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextWidget(
                      'Saved Address',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: TSize.s16),
                    BlocBuilder<AddressCubit, AddressState>(
                      builder: (context, state) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.address.length,
                          itemBuilder: (context, index) {
                            final address = state.address[index];

                            return Dismissible(
                              key: ValueKey(address.id),
                              background: _swipeToDelete(),
                              onDismissed: (direction) {
                                context.read<AddressCubit>().deleteAddress(address);
                              },
                              child: ListTile(
                                onTap: () async {
                                  context
                                      .read<AddressCubit>()
                                      .checkDefaultAddress(address);

                                  await context.push<LocationResult>(
                                      '${AddressScreen.routeName}/${AddNewAddressScreen.routeName}',
                                      extra: address);
                                },
                                title: Row(
                                  children: [
                                    TextWidget(
                                      address.addressNickname,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    if (address.isDefaultAddress)
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
                                subtitle: TextWidget(
                                  address.fullAddress,
                                ),
                                leading: IconWidget(
                                  name: 'location',
                                  color: theme.colorScheme.outline,
                                ),
                                trailing: Radio(
                                  value: index,
                                  groupValue: state.selectedAddress,
                                  onChanged: (int? value) {
                                    context.read<AddressCubit>().selectAddress(value);
                                  },
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: TSize.s64),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  context.read<AddressCubit>().checkDefaultAddress(null);

                  final latLng = await context.push<LocationResult>(
                      '${AddressScreen.routeName}/${AddNewAddressScreen.routeName}');

                  if (latLng != null) {
                    log('LatLng: ${latLng.latLng.toString()}');
                  }
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
            "Delete Address",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      );
}
