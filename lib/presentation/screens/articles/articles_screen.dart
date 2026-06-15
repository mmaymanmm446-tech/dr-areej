import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('المقالات')), body: ListView.builder(itemCount: 5, itemBuilder: (_, index) => Card(margin: const EdgeInsets.all(12), child: ListTile(title: Text('مقال ${index + 1}'), subtitle: const Text('نصائح طبية مهمة')))));
  }
}
