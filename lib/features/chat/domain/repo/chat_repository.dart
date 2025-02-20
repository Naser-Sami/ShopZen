import '/core/_core.dart';

abstract class IChatRepository {
  Future<void> sendMessage(String receiverId, String message);
  Stream<List<ChatMessage>> getMessages(String userId, String otherUserId);
}
