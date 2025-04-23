import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '/config/_config.dart' show TPadding, TSize, TextWidget;

class OnboardingScreenTextWidget extends StatefulWidget {
  const OnboardingScreenTextWidget({super.key});

  @override
  State<OnboardingScreenTextWidget> createState() =>
      _OnboardingScreenTextWidgetState();
}

class _OnboardingScreenTextWidgetState extends State<OnboardingScreenTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _initializeTextAnimationController();
    _setUpSlideAnimation();
    _setUpFadeAnimation();
    _setUpTextAnimation();
    super.initState();
  }

  void _initializeTextAnimationController() {
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  void _setUpSlideAnimation() {
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0, 0.5),
    ).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  void _setUpFadeAnimation() {
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.ease,
      ),
    );
  }

  void _setUpTextAnimation() {
    _textAnimationController.addListener(() {
      if (_textAnimationController.isCompleted) {
        _textAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
            animation: _textAnimationController,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    TextWidget(
                      'Welcome to ShopZen',
                      style: theme.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: TSize.s08),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: TPadding.p36),
                      child: TextWidget(
                        'Your one-stop destination for hassle-free online shopping',
                        style: theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            })
        .animate()
        .fade(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        )
        .scale(begin: const Offset(2, 2), end: const Offset(1, 1));
  }
}
