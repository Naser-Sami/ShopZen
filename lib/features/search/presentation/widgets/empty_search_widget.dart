import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: IconWidget(
                name: 'Search-rafiki 1',
                width: 250,
                height: 250,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'no result found!'.toString().asTitleCase,
                style: context.textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
