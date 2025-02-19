import 'package:flutter/material.dart';

class CustomerServiceChatBody extends StatelessWidget {
  const CustomerServiceChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Customer Service $index',
              style: theme.textTheme.bodyLarge,
            ),
          );
        },
      ),
    );
  }
}
