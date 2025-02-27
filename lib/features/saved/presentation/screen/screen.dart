import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class SavedItemsScreen extends StatelessWidget {
  static const routeName = '/saved';
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Saved Items'),
        actions: const [
          NotificationsIconWidget(),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconWidget(
              name: 'saved',
              width: TSize.s64,
              height: TSize.s64,
            ),
            TSize.s16.toHeight,
            TextWidget(
              "No Saved Items!",
              style: textTheme.titleLarge,
            ),
            TSize.s12.toHeight,
            TextWidget(
              "You don't have any saved items.",
              style: textTheme.bodySmall,
            ),
            TextWidget(
              "Go to home and add some.",
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
