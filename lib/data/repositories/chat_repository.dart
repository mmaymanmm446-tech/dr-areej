import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ChatMessage>> getChatHistory() async {
    final snapshot = await _firestore.collection('ai_chats').orderBy('timestamp').get();
    return snapshot.docs.map((doc) => ChatMessage.fromJson(doc.data())).toList();
  }

  Future<void> saveMessage(ChatMessage message) async {
    await _firestore.collection('ai_chats').doc(message.id).set(message.toJson());
  }

  Future<void> clearChat() async {
    final snapshot = await _firestore.collection('ai_chats').get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
