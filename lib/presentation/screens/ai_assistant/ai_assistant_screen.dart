import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/ai_assistant_provider.dart';
import 'message_bubble.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechToText.initialize();
    Future.microtask(() => Provider.of<AIAssistantProvider>(context, listen: false).loadChatHistory());
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    final message = _messageController.text;
    _messageController.clear();
    await Provider.of<AIAssistantProvider>(context, listen: false).sendMessage(message);
    _scrollToBottom();
  }

  void _startListening() async {
    final available = await _speechToText.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speechToText.listen(onResult: (result) {
        setState(() {
          _messageController.text = result.recognizedWords;
          _isListening = false;
        });
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      await Provider.of<AIAssistantProvider>(context, listen: false).uploadAndAnalyzeFile(result.files.first);
    }
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      await Provider.of<AIAssistantProvider>(context, listen: false).analyzeImage(image);
    }
  }

  void _scrollToBottom() => WidgetsBinding.instance.addPostFrameCallback((_) { if (_scrollController.hasClients) _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut); });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المساعد الطبي الذكي'), actions: [IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => Provider.of<AIAssistantProvider>(context, listen: false).clearChat())]),
      body: Column(children: [
        Expanded(child: Consumer<AIAssistantProvider>(builder: (context, provider, _) {
          if (provider.isLoading && provider.messages.isEmpty) return const Center(child: CircularProgressIndicator());
          return ListView.builder(controller: _scrollController, padding: const EdgeInsets.all(16), itemCount: provider.messages.length, itemBuilder: (context, index) => MessageBubble(message: provider.messages[index], isUser: provider.messages[index].isUser));
        })),
        Consumer<AIAssistantProvider>(builder: (context, provider, _) => provider.isTyping ? const Padding(padding: EdgeInsets.all(12), child: Text('يكتب...')) : const SizedBox.shrink()),
        Container(padding: const EdgeInsets.all(16), child: Row(children: [IconButton(icon: const Icon(Icons.attach_file), onPressed: _pickFile), IconButton(icon: Icon(_isListening ? Icons.mic : Icons.mic_none), onPressed: _startListening), IconButton(icon: const Icon(Icons.image), onPressed: _pickImage), Expanded(child: TextField(controller: _messageController, decoration: InputDecoration(hintText: 'اكتب سؤالك هنا...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)), onSubmitted: (_) => _sendMessage())), const SizedBox(width: 8), CircleAvatar(backgroundColor: Colors.deepPurple, child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 20), onPressed: _sendMessage))]))
      ]),
    );
  }
}
