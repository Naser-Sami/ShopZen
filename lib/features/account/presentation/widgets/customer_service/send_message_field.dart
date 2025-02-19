import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/config/_config.dart';

class CustomerServiceSendMessageField extends StatefulWidget {
  const CustomerServiceSendMessageField({super.key});

  @override
  State<CustomerServiceSendMessageField> createState() =>
      _CustomerServiceSendMessageFieldState();
}

class _CustomerServiceSendMessageFieldState
    extends State<CustomerServiceSendMessageField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.s12),
          border: Border.all(
            color: colorScheme.onSurface.withValues(alpha: 0.10),
          ),
        ),
        child: CupertinoTextFormFieldRow(
          controller: _controller,
          minLines: 1,
          maxLines: 6, // Adjust max height here
          keyboardType: TextInputType.multiline,

          placeholder: 'Write your message...',
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
