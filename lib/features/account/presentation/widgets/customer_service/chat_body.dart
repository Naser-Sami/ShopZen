import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

import 'receiver.dart';
import 'sender.dart';

class Message {
  final String text;
  final DateTime timestamp;
  final bool isSender;

  Message({required this.text, required this.timestamp, required this.isSender});
}

class CustomerServiceChatBody extends StatefulWidget {
  const CustomerServiceChatBody({super.key});

  @override
  State<CustomerServiceChatBody> createState() => _CustomerServiceChatBodyState();
}

class _CustomerServiceChatBodyState extends State<CustomerServiceChatBody> {
  List<Message> messages = [
    Message(
      text: 'Hello, Good morning.',
      timestamp: DateTime.now(),
      isSender: false,
    ),
    Message(
      text: 'I am a Customer Service, is there anything I can help you with?',
      timestamp: DateTime.now(),
      isSender: false,
    ),
    Message(
        text: "Hi, I'm having problems with my order & payment.",
        timestamp: DateTime.now(),
        isSender: true),
    Message(
      text: "Can you help me?",
      timestamp: DateTime.now(),
      isSender: true,
    ),
    Message(
      text: 'Of course...',
      timestamp: DateTime.now(),
      isSender: false,
    ),
    Message(
      text: 'Can you tell me the problem you are having? so I can help solve it',
      timestamp: DateTime.now(),
      isSender: false,
    ),
    Message(
        text: "Hi, I'm having problems with my order & payment.",
        timestamp: DateTime(2025, 2, 18),
        isSender: true),
    Message(
      text: "Can you help me?",
      timestamp: DateTime(2025, 2, 18),
      isSender: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isSender = message.isSender;

          // Check if it's the last message from the same sender
          final bool isLastFromSender = (index == messages.length - 1) ||
              (messages[index + 1].isSender != isSender);

          // Check if the current message is the first message of a new date
          final bool isFirstFromDate =
              index == 0 || messages[index - 1].timestamp.day != message.timestamp.day;

          return Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (isFirstFromDate)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    margin: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(TSize.s12),
                    ),
                    child: Text(
                      message.timestamp.formattedDateHeader(),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              isSender
                  ? CustomerServiceSender(message: message.text)
                  : CustomerServiceReceiver(message: message.text),
              if (!isLastFromSender) const SizedBox(height: TSize.s16),
              if (isLastFromSender) ...[
                const SizedBox(height: TSize.s08),
                Text(message.timestamp.formattedTimeOrDate()),
                const SizedBox(height: TSize.s16),
              ],
            ],
          );
        },
      ),
    );
  }
}
