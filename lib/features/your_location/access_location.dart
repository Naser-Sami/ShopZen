import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/features/_features.dart';
import '/config/_config.dart';
import '/core/_core.dart';

class AccessLocationScreen extends StatelessWidget {
  static const routeName = '/access-location';
  const AccessLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: TRadius.r42,
                child: IconWidget(
                  width: 36,
                  height: 36,
                  name: 'location2',
                ),
              ),
              const SizedBox(height: TSize.s24),
              TextWidget(
                'What\'t is Your Location?',
                style:
                    theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSize.s08),
              TextWidget(
                'We need to know your location in order to suggest nearby service.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSize.s48),
              ElevatedButton(
                onPressed: () async {
                  await sl<IGeolocatorService>().determinePosition().then((position) {
                    if (context.mounted) {
                      context.push(YourLocationScreen.routeName, extra: {
                        'lat': position.latitude,
                        'lng': position.longitude,
                      });
                    }
                  });
                },
                child: const TextWidget('Allow Location Access'),
              ),
              const SizedBox(height: TSize.s32),
              TextButton(
                onPressed: () {},
                child: const TextWidget('Enter Location Manually'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
