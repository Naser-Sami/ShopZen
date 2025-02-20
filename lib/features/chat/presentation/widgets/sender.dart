import 'package:flutter/material.dart';
import '/config/_config.dart';

class Sender extends StatelessWidget {
  final String message;
  const Sender({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * 0.75;

    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth, // Ensures max width is 75% of screen
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: TPadding.p20,
            vertical: TPadding.p12,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(
              alpha: 0.75,
            ),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(TSize.s12),
              topEnd: Radius.circular(TSize.s12),
              bottomStart: Radius.circular(TSize.s12),
            ),
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
