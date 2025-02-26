import 'dart:developer';

import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class YourLocationScreen extends StatefulWidget {
  static const routeName = '/your-location';
  const YourLocationScreen({super.key, required this.lat, required this.lng});

  final double lat, lng;

  @override
  State<YourLocationScreen> createState() => _YourLocationScreenState();
}

class _YourLocationScreenState extends State<YourLocationScreen> {
  final FocusNode? focusNode = FocusNode();

  bool inset = false;

  void _onInset(bool value) {
    setState(() {
      inset = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Location'),
      ),
      body: GestureDetector(
        onTap: () {
          _onInset(false);
          focusNode?.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: ListView(
            children: [
              NeumorphismContainer(
                inset: inset,
                blurRadius: 2,
                offset: Offset(2, 0),
                surfaceColor: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(TRadius.r08),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TPadding.p12),
                  child: TextField(
                    onTap: () async {
                      _onInset(true);
                      focusNode?.requestFocus();
                    },
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: TPadding.p12),
                      border: InputBorder.none,
                      hintText: 'Find your location',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TPadding.p12),
                        child: IconWidget(
                          name: 'search',
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSize.s24),
              ListTile(
                leading:
                    IconWidget(name: 'location-arrow', color: theme.colorScheme.primary),
                title: TextWidget('Use my current Location'),
                onTap: () async {
                  final address = await sl<IGeoCodeService>()
                      .getAddressFromCoordinates(widget.lat, widget.lng);

                  log('Country: ${address.countryName}');
                  log('City: ${address.city}');
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
