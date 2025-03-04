import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:place_picker_google/place_picker_google.dart' show LocationResult;
import 'package:shop_zen/features/address/presentation/screen/_screen.dart';

import '/config/_config.dart' show NotificationsIconWidget, TPadding, TextWidget, TSize;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () async {
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
}
