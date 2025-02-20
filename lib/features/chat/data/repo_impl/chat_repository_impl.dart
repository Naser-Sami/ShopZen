import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/features/chat/_chat.dart';
import '/core/_core.dart';

class ChatRepositoryImpl extends IChatRepository {
  final FirebaseFirestore _firestore = sl<FirebaseFirestore>();
  final FirebaseAuth _auth = sl<FirebaseAuth>();

  @override
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new chat message
    final ChatMessage chatMessage = ChatMessage(
      senderId: currentUserId,
      senderName: _auth.currentUser!.displayName.toString(),
      senderImage: _auth.currentUser!.photoURL.toString(),
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      read: false,
    );

    // construct chat room id from current use id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids (this ensure the chat room id is the same for any pair of users)
    String chatRoomId =
        ids.join('_'); // combine the ids into a single string to use as chatroom id

    // add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(chatMessage.toMap());
  }

  @override
  Stream<List<ChatMessage>> getMessages(String userId, String otherUserId) {
    // construct chat room id from user ids (sorted to ensure it matches the id used when sending messages)
    List<String> ids = [userId, otherUserId];
    ids.sort(); // sort the ids (this ensure the chat room id is the same for any pair of users)

    String chatRoomId =
        ids.join('_'); // combine the ids into a single string to use as chatroom id

    final querySnapshot = _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();

    return querySnapshot.map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ChatMessage.fromMap(data);
      }).toList();
    });
  }
}
