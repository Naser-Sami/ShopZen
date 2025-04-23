import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '/features/_features.dart';
import '/config/_config.dart';
import 'onboarding_screen_text_widget.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            const OnboardingScreenTextWidget(),
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
