import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class CustomerServiceSendMessageField extends StatefulWidget {
  const CustomerServiceSendMessageField({super.key, required this.receiverUserId});

  final String receiverUserId;

  @override
  State<CustomerServiceSendMessageField> createState() =>
      _CustomerServiceSendMessageFieldState();
}

class _CustomerServiceSendMessageFieldState
    extends State<CustomerServiceSendMessageField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode? focusNode = FocusNode();
  final _chatService = sl<IChatRepository>();

  @override
  void dispose() {
    _controller.dispose();
    focusNode?.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      _chatService.sendMessage(widget.receiverUserId, _controller.text.trim());
      _controller.clear();
      focusNode?.requestFocus();
    }
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
          keyboardType: TextInputType.none,
          style: theme.textTheme.bodyMedium,
          autofocus: true,
          focusNode: focusNode,
          onFieldSubmitted: (value) => _sendMessage(),
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
