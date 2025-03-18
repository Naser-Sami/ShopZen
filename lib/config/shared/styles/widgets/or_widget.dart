import 'package:flutter/material.dart';
import '/config/_config.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        const Flexible(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p10),
          child: TextWidget(
            'Or',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const Flexible(child: Divider()),
      ],
    );
  }
}
