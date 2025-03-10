import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class ChatRoomBody extends StatefulWidget {
  static const routeName = 'chat-room';
  const ChatRoomBody({super.key, required this.receiverUserId});

  final String receiverUserId;

  @override
  State<ChatRoomBody> createState() => _ChatRoomBodyState();
}

class _ChatRoomBodyState extends State<ChatRoomBody> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final _chatService = sl<IChatRepository>();
  final _firebaseAuth = sl<FirebaseAuth>();

  final StreamController<List<ChatMessage>> _streamController =
      StreamController<List<ChatMessage>>.broadcast();
  StreamSubscription<List<ChatMessage>>? _subscription;

  @override
  void initState() {
    super.initState();

    // ✅ Subscribe to Firestore stream and cache messages
    _subscription = _chatService
        .getMessages(widget.receiverUserId, _firebaseAuth.currentUser!.uid)
        .listen((messages) {
      _streamController.add(messages);
    });
  }

  bool _isFirstBuild = true; // ✅ Track if the screen is opened for the first time

  @override
  void dispose() {
    _scrollController.dispose();
    _subscription?.cancel();
    _streamController.close();
    super.dispose();
  }

  void _scrollToBottom({bool instant = false}) {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    }
  }

  @override
  bool get wantKeepAlive => true; // ✅ Keeps state when navigating

  @override
  Widget build(BuildContext context) {
    super.build(context); // ✅ Required when using AutomaticKeepAliveClientMixin

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Expanded(
      child: StreamBuilder<List<ChatMessage>>(
        stream: _streamController.stream, // ✅ Use cached stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No messages yet.'));
          }

          List<ChatMessage> messages = snapshot.data ?? [];

          // ✅ Ensure chat starts from the bottom when first opened
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_isFirstBuild) {
              _scrollToBottom(instant: true);
              _isFirstBuild = false;
            } else {
              _scrollToBottom();
            }
          });

          return ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                .onDrag, // ✅ Prevents unnecessary rebuilds
            controller: _scrollController, // ✅ Attach the controller
            itemCount: messages.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final message = messages[index];

              // ✅ Fix: Prevent `timestamp` null errors by using a fallback value
              final DateTime dateTime = message.timestamp.toDate();

              final bool isSender = _isSender(message);
              final bool isLastFromSender = _isLastFromSender(messages, index, isSender);
              final bool isFirstFromDate = _isFirstFromDate(messages, index, dateTime);

              return Column(
                key: ValueKey('chat-message-$index'),
                crossAxisAlignment:
                    isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (isFirstFromDate) _buildDateHeader(dateTime, colorScheme, textTheme),
                  isSender
                      ? Sender(message: message.message)
                      : Receiver(message: message.message),
                  if (!isLastFromSender) const SizedBox(height: TSize.s16),
                  if (isLastFromSender) _buildTimestamp(dateTime),
                ],
              );
            },
          );
        },
      ),
    );
  }

  /// **Check if the message is from the current user**
  bool _isSender(ChatMessage message) {
    return message.senderId == sl<FirebaseAuth>().currentUser!.uid;
  }

  /// **Check if it's the last message from the same sender**
  bool _isLastFromSender(List<ChatMessage> messages, int index, bool isSender) {
    return (index == messages.length - 1) ||
        ((messages[index + 1].senderId != widget.receiverUserId) != isSender);
  }

  /// **Check if the current message is the first message of a new date**
  bool _isFirstFromDate(List<ChatMessage> messages, int index, DateTime dateTime) {
    if (index == 0) return true; // The first message always gets a date header

    final previousMessageTimestamp = messages[index - 1].timestamp as Timestamp?;
    final DateTime previousDate = previousMessageTimestamp?.toDate() ?? DateTime.now();

    return previousDate.day != dateTime.day;
  }

  /// **Date Header for a new day**
  Widget _buildDateHeader(
      DateTime dateTime, ColorScheme colorScheme, TextTheme textTheme) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        margin: const EdgeInsets.only(bottom: 24.0, top: 16.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withAlpha(127),
          borderRadius: BorderRadius.circular(TSize.s12),
        ),
        child: Text(
          dateTime.formattedDateHeader(),
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// **Timestamp for the last message of the sender**
  Widget _buildTimestamp(DateTime dateTime) {
    return Column(
      children: [
        const SizedBox(height: TSize.s08),
        Text(dateTime.formattedTimeOrDate()),
        const SizedBox(height: TSize.s16),
      ],
    );
  }
}
