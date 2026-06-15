import 'package:flutter/material.dart';
import '../../../data/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isUser;

  const MessageBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: isUser ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: isUser ? Colors.deepPurple : Colors.grey[200], borderRadius: BorderRadius.circular(18)), child: Text(message.text, style: TextStyle(color: isUser ? Colors.white : Colors.black87))));
  }
}
