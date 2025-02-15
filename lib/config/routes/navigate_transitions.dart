import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<dynamic> fadeTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Change the opacity of the screen using a Curve based on the the animation's value
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

// -- Slide Transition: Slide in from the right.
CustomTransitionPage<void> slideTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// -- Scale Transition: Zoom in.
CustomTransitionPage<void> scaleTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
  );
}

// -- Rotate Transition: Rotate in.
CustomTransitionPage<void> rotateTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return RotationTransition(
        turns: animation,
        child: child,
      );
    },
  );
}

// -- Fade and Slide Combination: Fade in and slide up.
CustomTransitionPage<void> fadeSlideTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: offsetAnimation,
          child: child,
        ),
      );
    },
  );
}

// -- Slide in from the Bottom
CustomTransitionPage<void> slideFromBottomPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// -- Slide in from the Top
CustomTransitionPage<void> slideFromTopPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// -- Scale Down Transition
CustomTransitionPage<void> scaleDownTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scaleAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(animation);
      return ScaleTransition(
        scale: scaleAnimation,
        child: child,
      );
    },
  );
}

// -- Slide and Fade Transition
CustomTransitionPage<void> slideFadeTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      final tween = Tween(begin: begin, end: Offset.zero);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

// -- Scale and Rotate Transition
CustomTransitionPage<void> scaleRotateTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: animation,
        child: RotationTransition(
          turns: animation,
          child: child,
        ),
      );
    },
  );
}

// -- Flip Transition
CustomTransitionPage<void> flipTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
      return AnimatedBuilder(
        animation: flipAnimation,
        builder: (context, child) {
          final angle = flipAnimation.value * 3.14; // Rotate by 180 degrees
          return Transform(
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: child,
          );
        },
        child: child,
      );
    },
  );
}

// -- Slide Up and Scale Down
CustomTransitionPage<void> slideUpScaleDownPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation);
      final scaleAnimation = Tween<double>(begin: 1.2, end: 1.0).animate(animation);

      return SlideTransition(
        position: offsetAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      );
    },
  );
}

// -- Zoom In Transition
CustomTransitionPage<void> zoomInTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    },
  );
}

// -- Zoom Out Transition
CustomTransitionPage<void> zoomOutTransitionPage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 1.5, end: 1.0).animate(animation),
        child: child,
      );
    },
  );
}

// -- Slide in from Left with Rotation
CustomTransitionPage<void> slideLeftRotatePage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(animation);
      return SlideTransition(
        position: offsetAnimation,
        child: RotationTransition(
          turns: animation,
          child: child,
        ),
      );
    },
  );
}

// -- 
// -- 
// -- 
// -- 
// -- 
// -- 
// -- 
// -- 