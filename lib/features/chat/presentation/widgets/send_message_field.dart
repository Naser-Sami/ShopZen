import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  // For Voice Recording
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  /// This has to happen only once per app
  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await speechToText.stop();
    setState(() {
      showMic = false;
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      _controller.text = lastWords;
    });
  }
  // End of Voice Recording

  @override
  void initState() {
    super.initState();
    _initSpeech();
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

  void _sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      _chatService.sendMessage(widget.user.uid, _controller.text.trim());

      try {
        await createOrSendNotification(
          uid: widget.user.uid,
          fcmToken: widget.user.fcmToken,
          title: sl<UserCubit>().state?.name ?? "Anonymous",
          body: _controller.text.toString(),
          type: NotificationsType.newMessage,
          icon: 'new_message',
          senderId: sl<UserCubit>().state?.uid ?? "",
          data: {
            'userId': sl<UserCubit>().state?.uid ?? "",
            'name': sl<UserCubit>().state?.name ?? "",
            "notificationType": NotificationsType.newMessage.name,
            'user': jsonEncode(
                sl<UserCubit>().state!.toMap()) // encode the map to a JSON string
          },
        );

        _controller.clear();
        focusNode?.requestFocus();
      } catch (e) {
        log('Error sending notification On Send Message: $e');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode?.dispose();
    super.dispose();
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
        Container(
          width: TSize.s56,
          height: TSize.s56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSize.s12),
            color: colorScheme.primary,
          ),
          child: IconButton(
            onPressed: () {
              if (showMic) {
                speechToText.isNotListening ? _startListening() : _stopListening();
              } else {
                _sendMessage();
              }
            },
            tooltip: 'Listen',
            icon: Icon(
              showMic
                  ? (speechToText.isNotListening
                      ? CupertinoIcons.mic
                      : CupertinoIcons.mic_off)
                  : CupertinoIcons.paperplane,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
