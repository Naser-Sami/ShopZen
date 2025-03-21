import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/features/_features.dart';
import '/config/_config.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    void navToLogin() {
      // context.push(AccessLocationScreen.routeName);
      context.push(LoginWithSocialScreen.routeName);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconWidget(
                name: 'onboarding_image',
                width: size.width,
                height: size.height * 0.45,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: TSize.s48),
            TextWidget(
              'Welcome to ShopZen',
              style: theme.textTheme.headlineLarge,
            ),
            const SizedBox(height: TSize.s08),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TPadding.p36),
              child: TextWidget(
                'Your one-stop destination for hassle-free online shopping',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: TSize.s64),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
              child: ElevatedButton(
                onPressed: navToLogin,
                child: const TextWidget("Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
