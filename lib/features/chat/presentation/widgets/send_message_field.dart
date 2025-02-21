import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class SendMessageField extends StatefulWidget {
  const SendMessageField({super.key, required this.user});

  final UserModel user;

  @override
  State<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
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
      _chatService.sendMessage(widget.user.uid, _controller.text.trim());
      _controller.clear();
      focusNode?.requestFocus();

      try {
        sl<INotificationsService>().sendNotification(
          token:
              "dMFO7BpnTvSg91dSF3iXn8:APA91bEWMdzaP_J6OiUs3dtKO88OeajJmtVj86jGUpOhPPJedgxJKvSJNI1Zfj6HLn9ZwROX2kp5PmwYVCNH6oi6Bj3R12EjDxA9l6jQ1aMjTBsqBgR4o8o",
          title: widget.user.name,
          body: _controller.text.trim(),
          data: {},
        );
      } catch (e) {
        log('Error sending notification: $e');
      }
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
          keyboardType: TextInputType.text,
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
