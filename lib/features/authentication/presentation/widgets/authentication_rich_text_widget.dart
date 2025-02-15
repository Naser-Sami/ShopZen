import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class AuthenticationRichTextWidget extends StatelessWidget {
  const AuthenticationRichTextWidget(
      {super.key,
      required this.navToSignUp,
      required this.text,
      required this.hyperlinkText});

  final VoidCallback navToSignUp;
  final String text;
  final String hyperlinkText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: theme.textTheme.bodyMedium,
          ),
          TextSpan(
            text: hyperlinkText,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = navToSignUp,
            // recognizer: DoubleTapGestureRecognizer()..onDoubleTap = (){},
            // recognizer: LongPressGestureRecognizer()..onLongPress = () {},
          ),
        ],
      ),
    );
  }
}
