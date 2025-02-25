import 'dart:convert';
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
          fcmToken: widget.user.fcmToken,
          title: sl<UserCubit>().state?.name ?? "Anonymous",
          body: _controller.text.toString(),
          notificationType: 'chat',
          data: {
            'userId': sl<UserCubit>().state?.uid ?? "",
            'name': sl<UserCubit>().state?.name ?? "",
            'user': jsonEncode(
                sl<UserCubit>().state!.toMap()) // encode the map to a JSON string
          },
        );
      } catch (e) {
        log('Error sending notification On Send Message: $e');
      }
    }
  }

  bool showMic = true;

  void _toggleMic() {
    if (_controller.text.isEmpty) {
      setState(() {
        showMic = true;
      });
    } else {
      setState(() {
        showMic = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        Expanded(
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
              onChanged: (value) => _toggleMic(),
              onFieldSubmitted: (value) => _sendMessage(),
              placeholder: 'Write your message...',
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: TSize.s16),
        MicButton(
          icon: showMic ? CupertinoIcons.mic : CupertinoIcons.paperplane,
          onPressed: () {
            if (showMic) {
            } else {
              _sendMessage();
            }
          },
        ),
      ],
    );
  }
}
