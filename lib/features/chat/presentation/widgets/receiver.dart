import 'package:flutter/material.dart';
import '/config/_config.dart';

class Receiver extends StatelessWidget {
  final String message;

  const Receiver({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.75;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth, // Ensures max width is 75% of screen
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TPadding.p20,
            vertical: TPadding.p12,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(TSize.s12),
              topEnd: Radius.circular(TSize.s12),
              bottomEnd: Radius.circular(TSize.s12),
            ),
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
