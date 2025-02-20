import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String senderId;
  final String senderName;
  final String senderImage;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final bool read;

  const ChatMessage({
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.read,
  });

  // copy with method
  ChatMessage copyWith({
    String? senderId,
    String? senderName,
    String? senderImage,
    String? senderEmail,
    String? receiverId,
    String? message,
    Timestamp? timestamp,
    bool? read,
  }) =>
      ChatMessage(
        senderId: senderId ?? this.senderId,
        senderName: senderName ?? this.senderName,
        senderImage: senderImage ?? this.senderImage,
        senderEmail: senderEmail ?? this.senderEmail,
        receiverId: receiverId ?? this.receiverId,
        message: message ?? this.message,
        timestamp: timestamp ?? this.timestamp,
        read: read ?? this.read,
      );

  // from map
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      senderImage: map['senderImage'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
      read: map['read'] as bool,
    );
  }

  // convert to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'read': false,
    };
  }

  @override
  List<Object?> get props => [
        senderId,
        senderName,
        senderImage,
        senderEmail,
        receiverId,
        message,
        timestamp,
        read
      ];
}
