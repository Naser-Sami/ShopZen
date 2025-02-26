import 'package:flutter/material.dart';
import 'package:flutter_location_search/flutter_location_search.dart';

import '/config/_config.dart';

class SelectLocationScreen extends StatefulWidget {
  static const routeName = '/select-location';
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final FocusNode? focusNode = FocusNode();
  String _locationText = 'Tap here to search a place';

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
        title: TextWidget('Enter Your Location'),
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
                borderRadius: BorderRadius.circular(TRadius.r08),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TPadding.p12),
                  child: TextField(
                    onTap: () async {
                      _onInset(true);
                      focusNode?.requestFocus();

                      LocationData? locationData = await LocationSearch.show(
                        context: context,
                        lightAddress: true,
                        mode: Mode.fullscreen,
                      );

                      if (locationData == null) return;

                      _locationText = locationData.address;
                      setState(() {});
                    },
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: TPadding.p12),
                      border: InputBorder.none,
                      hintText: 'Find your location',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TPadding.p12),
                        child: IconWidget(name: 'search'),
                      ),
                    ),
                  ),
                ),
              ),

              // TextButton(
              //   child: Text(
              //     _locationText,
              //     style: theme.textTheme.bodyLarge,
              //   ),
              //   onPressed: () async {
              // LocationData? locationData = await LocationSearch.show(
              //   context: context,
              //   lightAddress: true,
              //   mode: Mode.fullscreen,
              // );

              // if (locationData == null) return;

              // _locationText = locationData.address;
              // setState(() {});
              //   },
              // ),
              const SizedBox(height: TSize.s64),
            ],
          ),
        ),
      ),
    );
  }
}
