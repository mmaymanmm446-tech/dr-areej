import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../../data/models/chat_message.dart';
import '../../data/repositories/chat_repository.dart';

class AIAssistantProvider extends ChangeNotifier {
  final ChatRepository _chatRepository = ChatRepository();
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isTyping = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  bool get isTyping => _isTyping;

  Future<void> loadChatHistory() async {
    _isLoading = true;
    notifyListeners();
    _messages = await _chatRepository.getChatHistory();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    final userMessage = ChatMessage(id: DateTime.now().toString(), text: message, isUser: true, timestamp: DateTime.now());
    _messages.add(userMessage);
    notifyListeners();
    _isTyping = true;
    notifyListeners();

    try {
      final response = await _callOpenAI(message);
      final aiMessage = ChatMessage(id: DateTime.now().toString(), text: response, isUser: false, timestamp: DateTime.now());
      _messages.add(aiMessage);
      await _chatRepository.saveMessage(aiMessage);
    } catch (e) {
      _messages.add(ChatMessage(id: DateTime.now().toString(), text: 'عذراً، حدث خطأ. يرجى المحاولة مرة أخرى.', isUser: false, timestamp: DateTime.now()));
    }

    _isTyping = false;
    notifyListeners();
  }

  Future<String> _callOpenAI(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppConstants.openAIApiKey}',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': 'You are a helpful medical assistant. Provide accurate and professional medical information in Arabic.'},
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.7,
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['message']['content'];
    }
    throw Exception('Failed to get AI response');
  }

  Future<void> uploadAndAnalyzeFile(PlatformFile file) async {
    // Placeholder for future file upload/analysis integration.
    debugPrint('File upload requested for ${file.name}');
  }

  Future<void> analyzeImage(XFile image) async {
    // Placeholder for future image analysis integration.
    debugPrint('Image analysis requested for ${image.path}');
  }

  void clearChat() {
    _messages.clear();
    _chatRepository.clearChat();
    notifyListeners();
  }
}
